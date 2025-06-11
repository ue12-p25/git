---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  display_name: Calysto Bash
  language: bash
  name: calysto_bash
language_info:
  help_links:
  - text: MetaKernel Magics
    url: https://metakernel.readthedocs.io/en/latest/source/README.html
  name: bash
nbhosting:
  title: git pour les cours
---

License CC BY-NC-ND, Thierry Parmentelat & Valérie Roy

```{code-cell}
%%python
from IPython.display import HTML
HTML(filename="_static/style.html")
```

+++ {"slideshow": {"slide_type": ""}}

# aperçu de l'implémentation

+++

ce notebook est complètement **optionnel**

on s'intéresse à la façon dont les commits sont stockés dans le repository  
on n'a **pas du tout besoin** de savoir ça pour utiliser `git` pleinement, mais cela pourra peut-être satisfaire la curiosité de certains

pour plus de détails, je vous renvoie à cette page <https://git-scm.com/book/en/v2/Git-Internals-Git-Objects>

+++

## plusieurs types d'objets

en fait pour décrire un *commit* on a besoin de 3 types d'objets

* `commit`, pour représenter, eh bien .. un commit
* `tree`, pour le contenu d'un dossier
* `blob`, pour le contenu d'un fichier usuel

et pour faire court, on voit ça en détail tout de suite, mais

* un `commit` contient des infos administratives (auteur/dat/message) + 1 `tree` (et un ou des parent.s)
* un `tree` contient une collection de `tree` et/ou `blob`
* un `blob` contient tout simplement le fichier tel-quel

sachant que pour gagner de la place tout ceci est compressé

+++

## le type *commit*

un object `commit` est implémenté comme un simple fichier texte compressé  
et pour le voir il suffit de faire

```bash
git cat-file <le-commit>
```

voyons ce que ça nous donne avec le commit courant:

```{code-cell}
# voyons un peu où nous en sommes dans ce repo
git log -3 --oneline
```

```{code-cell}
# je me livre à une petite gymnastique en bash 
# pour calculer le hash du commit courant

# on le range dans une variable
commit_hash=$(git log -1 --pretty='%h')

# et on l'affiche
# vous pouvez vérifier dans le git log au dessus
echo le hash du commit courant est $commit_hash
```

```{code-cell}
# et voici le contenu typique d'un objet de type 'commit'

git cat-file -p $commit_hash
```

comme on le voit, c'est un fichier texte tout simple, avec pour commencer 4 informations (tree, parent, author, committer) et ensuite le message du commit

ce sont les deux premiers qui vont nous intéresser maintenant, car ils méritent une explication:

* le `parent`, c'est tout simplement le hash du commit parent (il peut y en avoir plusieurs si on regarde un commit de fusion)
* le `tree`, c'est un objet qui va nous dire le contenu de ce commit

et du coup le hash correspondant au `tree`, puisque ça donne le détail du dossier à la racine du repo,
n'est pas un objet de type `commit`, mais de type `tree`

regardons ça de plus près

+++

## le type *tree*

c'est le même principe, on obtient le contenu de cet objet à partir de son hash, en utilisant comme plus haut la commande `cat-file`

à nouveau regardons ce que ça donne avec le commit courant

```{code-cell}
# pareil, on fait un peu de contorsions en bash pour calculer 
# le hash du `tree` du commit 
# un peu de magie noire, ce n'est pas utile 
# de comprendre le détail de cette commande ;)

tree_hash=$(git cat-file -p $commit_hash | grep '^tree ' | cut -d' ' -f2)

# vérifiez que c'est bien ce qui apparaissait dans la première ligne du commit
echo le hash du tree du commit courant est $tree_hash
```

et voici donc le contenu typique d'un objet de type `tree`

```{code-cell}
git cat-file -p $tree_hash
```

cette fois, on voit une simple collection d'objets, un mélange de `tree` et de `blob`  
et vous l'avez deviné, cette liste donne le contenu du dossier principal du commit:

- une entrée de type `tree` signale la présence d'un sous-dossier
- une entrée de tyle `blob` correspond à un fichier usuel

ainsi pour être concret avec un listing comme celui-ci
```console
100644 blob ffdd283698ab76f28f262894cbf9b4cc005f953f	.gitignore
040000 tree 4d747763edc535af280224922965319fb5e5ec1a	.nbhosting
100644 blob edd15baff204eac4b179b23522ff545a9b9bc9ab	README.md
040000 tree 0dced09e30493575a6f77d51d7b9ab6687d869cb	notebooks
100644 blob 9aff54ee714f94ca4ff615a678d558a62bdefd8b	requirements.txt
```
on sait que le commit contient à sa racine:

* 2 sous-dossiers qui s'appellent `.nbhosting` et `notebooks`
* et 3 fichiers `.gitignore`, `README.md` et `requirements.txt`

pour retrouver le contenu des sous-dossiers, eh bien on vient de voir comment ça marche

+++

## le type *blob*

il ne reste plus qu'à comprendre comment on retrouve le contenu des fichiers usuels
ça ne peut pas être plus simple, l'objet est tout simplement sauvé comme le fichier compressé

voyons ça, on va utiliser .. `cat-file` de nouveau, bien sûr  
et avec le premier blob qui est mentionné ça nous donnerait

```{code-cell}
# calculons le hash du premier blob
# passons sur les détails

blob_hash=$(git cat-file -p $tree_hash | grep ' blob ' | head -1 | awk '{print $3;}')

#
echo le premier blob a pour hash $blob_hash
```

```{code-cell}
# et voici maintenant le contenu du fichier correspondant à ce blob
# qui correspond bien au contenu du .gitignore à la racine du repo
# (et vous pouvez vérifier dans votre repo)

git cat-file -p $blob_hash
```

## mais c'est rangé où ?

chacun de ces objets est rangé dans un fichier sous `.git/objects`; par exemple

* l'objet dont le hash est  
  `             ffdd283698ab76f28f262894cbf9b4cc005f953f`

* est rangé dans le fichier  
  `.git/objects/ff/dd283698ab76f28f262894cbf9b4cc005f953f`

c'est-à-dire que les deux premiers caractères du hash servent pour le nom du dossier, et le reste pour le nom du fichier  
il s'agit d'une simple optimisation pour éviter de se retrouver avec un trop grand nombre de fichiers dans un seul dossier

+++

## et sous quel format ?

le fichier sous `.git/objects` contient le texte (celui qu'on a vu avec `cat-file`) simplement compressé avec un outil qui s'appelle `zlib`

on trouve `zlib-flate` dans le package `qpdf`  
(merci à <https://unix.stackexchange.com/questions/22834/how-to-uncompress-zlib-data-in-unix> pour les détails)

```{code-cell}
# ici il faut bien sûr utiliser le hash complet, pas le raccourci
full_commit_hash=$(git log -1 --pretty='%H')

echo le hash complet du commit est $full_commit_hash
```

```{code-cell}
# on extrait les deux morceaux:
# les deux premiers caractères
dir_part=${full_commit_hash:0:2}
# le reste
file_part=${full_commit_hash:2:38}

path=".git/objects/$dir_part/$file_part"

echo le fichier qui stocke le commit doit se trouver dans $path
```

```{code-cell}
# voyons si le fichier existe bien
# je remonte d'un cran car nous sommes dans le dossier notebooks/
ls -l ../$path
```

et donc maintenant qu'on a localisé le fichier on peut le décompresser

```{code-cell}
cat ../$path | zlib-flate -uncompress
```

et on se convainc comme ça que `cat-file` ne fait pas grand-chose de plus que de décompresser le hash qu'on lui passe

+++

````{admonition} avec gzip
:class: seealso dropdown

on peut aussi décompresser directement en bash avec `gzip`, même si c'est encore plus cryptique que la magie noire de tout à l'heure :)
(merci à <https://unix.stackexchange.com/questions/22834/how-to-uncompress-zlib-data-in-unix> pour cette astuce)

```bash
(printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; cat ../$path) | gzip -dc
```
à la fin `gzip` se plaint qu'il manque le footer de checksum, mais c'est suffisant pour ce qu'on cherche à faire...
````

+++

## quelques références pour aller plus loin

ces deux liens sont des micro-implémentations - en Python et JavaScript respectivement:

* <https://benhoyt.com/writings/pygit/>
* <http://gitlet.maryrosecook.com/docs/gitlet.html>


avec énormément d'explications qui peuvent éclairer certains points, dont notamment pour le premier lien, l'implémentation de l'index.
