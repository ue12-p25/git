---
jupytext:
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
---

License CC BY-NC-ND, Thierry Parmentelat & Valérie Roy

```{code-cell}
%%python
from IPython.display import HTML
HTML(filename="_static/style.html")
```

# synchro entre dépôts : tirer

````{admonition} lire les vidéos dans Jupyter lab
:class: tip

ce notebook contient des vidéos; si vous le lisez dans Jupyter, pour que les vidéos s'affichent:  
assurez-vous d'exécuter toutes les cellules avec *Run* -> *Run All Cells*
````

+++

## on contextualise

+++

### jusqu'ici on est resté local

**jusqu'ici** on a abordé `git` du point de vue **"usage local"**; on a créé tous nos commits et branches localement, on n'a eu à **aucun moment besoin du réseau**.

notez que même dans ce cadre délibérément limité, `git` remplit déjà plein de fonctions super utiles :

* les commits sont des sauvegardes, si on s'embrouille à un moment on peut facilement revenir à un état stable
* on a une trace structurée de tous les changements, par qui, quand, pourquoi
* on peut revenir en arrière
* on peut découper le travail en problèmes indépendants, en créant autant de **branches** que nécessaire
* on peut intégrer (**merge / fusionner**) facilement, une fois que tous les morceaux sont terminés

+++

### en réseau

mais bien sûr, on l'a vu dans les slides d'introduction, on peut aussi utiliser git pour travailler à plusieurs

```{image} media/kn2-synchro-overview.svg
:align: center
```

````{admonition} le réseau
:class: note

pour ça, on va **utiliser le réseau pour synchroniser deux dépôts**

l'architecture ci-dessus n'est pas la seule possible, mais c'est un cas hyper fréquent:  
le repo au milieu est hébergé sur github, il sert de relais entre les ordis de bob et d'alice, qui du coup n'ont pas besoin de communiquer entre eux directement
````

+++

## aller chercher

en réalité il y a très peu de commandes de git qui tombent dans la catégorie des synchros entre dépôts

nous allons les étudier pas à pas, et pour commencer **dans ce premier notebook** nous allons étudier les commandes qui **mettent à jour le dépôt local**, c'est-à-dire :

* `git clone` (pour initialiser à partir de, par exemple github)
* `git pull` (pour mettre à jour ultérieurement)

et du coup en passant on va parler aussi de `git fetch` qui est, si on veut, un sous-produit de `git pull`

+++

## `git clone`

mais pour commencer, voyons `git clone`; on a rencontré et même déjà utilisé cette commande, c'est celle qui permet en partant de rien, de dupliquer un dépôt, typiquement trouvé sur github; le fonctionnement est simple, et peut être illustré comme ceci

````{admonition} rappel: toujours utiliser les URLs en SSH

````

```{code-cell}
---
slideshow:
  slide_type: ''
tags: []
---
%%python
from ipywidgets import Video
Video.from_file("_static/Clone.mp4", autoplay=False, loop=False)
```

```{code-cell}

```

* dans un premier temps on duplique le graphe des commits, y compris le commit courant
* à partir de quoi on peut remplir l'index et les fichiers

+++

nous allons l'exécuter sur un repo de test pour mettre en évidence d'autres effets de la commande  
vérifiez que vous n'avez pas de dossier qui s'appelle `sandbox`, et tapez la commande

```bash
$ git clone git@github.com:ue12-p24/git-sandbox.git sandbox
Cloning into 'sandbox'...
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 0), reused 4 (delta 0), pack-reused 0
Receiving objects: 100% (4/4), done.
```

cela a eu pour effet de créer un dossier `sandbox` (le dernier paramètre passé à `git clone`); allons-y

```bash
cd sandbox
```

+++

## les *remotes*

tapons maintenant la commande

```bash
$ git remote
origin
```

interprétons cette réponse sybilline :

* `git` nous dit que notre dépôt a un copain  
* dans le sens où : on a connaissance d'un **autre dépôt**, qui contient le **même projet**  
* dans le jargon `git`, un tel dépôt s'appelle un *remote*  
* et par commodité, `git clone` crée un *remote* pour se souvenir d'où on a fait le clône  
  car il y a toutes les chances qu'on ait de nouveau à échanger avec lui  
  et lui donne par convention le nom de **`origin`**

````{admonition} ce qu'il faut bien comprendre

* dans notre cas, ce dépôt, c'est bien sûr celui sur github - ça pourrait être quoi d'autre ?
* et surtout, ce nom `origin` en fait c'est **juste un alias** pour l'URL  
  `git@github.com:ue12-p24/git-sandbox.git`

on va pouvoir utiliser ce nom à chaque fois qu'on voudra utiliser une commande de synchronisation, comme `push`, `pull`, enfin tout ce qu'on va voir tout de suite
````

+++

d'ailleurs pour le vérifier, on peut faire

```bash
$ git remote get-url origin
git@github.com:ue12-p24/git-sandbox.git
```

+++

````{admonition} le nom origin
:class: note

le remote `origin` est créé par `git clone`  
c'est pourquoi lorsqu'on procède dans l'autre sens (un repo créé localement qu'on veut ensuite pousser sur github),
la formule proposée par github comporte justement la création manuelle du remote origin

```{image} media/git-remote-add.png
:align: center
```
````

+++

## `git pull`

à quoi ça sert un remote ?

une fois qu'on a cloné, on est redevenu totalement autonome; on pourrait par exemple couper le réseau, on a tout ce qu'il faut localement pour modifier le code, on peut travailler dans son coin, et créer localement des commits si on en a besoin

ça n'empêche pas que de temps en temps on a envie d'aller voir s'il n'y a pas eu des nouveautés; pour ça on va retourner **demander au dépôt initial s'il y a du nouveau**

pour ça la deuxième commande de synchronisation qu'on est amené à utiliser lorsqu'on a cloné un dépôt, c'est `git pull`

le `pull` va procéder en deux temps:

- `fetch` va aller chercher les éventuels nouveaux commits
- et s'il y a du nouveau, on va faire `merge` dans le commit courant

et commençons par regarder son fonctionnement illustré dans une vidéo (dans le prolongement du clip précédent)  

````{admonition} comme toujours: on part d'un repo propre
:class: dropdown

on fait ici l'hypothèse qu'on n'a pas touché à notre repo local, et que donc il est propre
````

```{code-cell}
:tags: [remove-input]

%%python
from ipywidgets import Video
Video.from_file("_static/Pull.mp4", autoplay=False, loop=False)
```

pour résumer, on peut dire que

````{admonition} pull
:class: note

`git pull` = `git fetch` + `git merge`


```{admonition} ou rebase..
:class: dropdown warning

pour les geeks, sachez qu'on peut aussi demander à `pull` de faire plutôt `fetch` + `rebase`, mais c'est une autre histoire...
```
````

+++

### `git pull` est intrusif

le premier point important à retenir, c'est que

* `git fetch` est une opération **totalement inoffensive**, elle n'a **pas d'impact** sur l'état de notre dépôt  
  (commit courant + index + fichiers)

* **dans un `pull` par contre**, c'est la partie `merge` - qu'on a déjà étudiée  
  qui elle, peut **avoir un impact sur l'état du dépôt** (commit courant + index + fichiers)
  
donc déja, comme premier conseil, il est bon de prendre l'habitude faire `git pull` **dans un dépôt propre**

+++

### branches distantes

le second point à retenir, c'est le rôle des références de branches distantes, comme par exemple

`origin/main`

on a vu dans la vidéo que `origin/main`:

* ça correspond à une étiquette **locale** (dans le repo local)
* qui nous permet de savoir où se trouve la branche `main` dans le dépôt **distant** (le remote) `origin`

+++

il faut insister sur le fait que c'est une **information locale** et que c'est du *best effort*; on ne **garantit pas** que cette information est **toujours à jour**, car elle est uniquement mise à jour par `git fetch`

dit autrement, si vous ne faites jamais ni `git pull` ni `git fetch` pendant un mois, vous aurez toujours `origin/main` qui pointe dans votre dépôt au même endroit, alors que sur github la branche aura sans doute avancé...

+++

````{admonition} note
:class: note

en pratique on fait plus souvent `git pull` que `git fetch`, car bien sûr souvent ce qu'on veut faire c'est se mettre à jour; et mon opinion c'est que c'est un peu dommage, car le fait de faire d'abord `fetch` permet de bien évaluer l'impact que va avoir le `pull` (notamment : est-ce un fast-forward ?)

une fois qu'on a dit ça, si vous utilisez une GUI comme `Sourcetree` ou `Fork` ou `Tower` ou autre, il y a de fortes chances qu'elle fasse pour vous un `git fetch` **automatiquement** - genre toutes les 5 minutes; et c'est très pratique car ça permet, justement, de recevoir des notifications lorsqu'il y a du nouveau dans le dépôt *upstream*
````

+++

### *fast-forward* ou pas ?

la troisième chose à retenir est que, puisque `pull` finit par faire un `merge`, tout ce qu'on a appris sur le merge s'applique ici aussi; et notamment :

* premier cas (comme dans la vidéo) si le commit qui vient de l'*upstream* est un enfant de mon commit  
 (donc en gros, si je n'ai **pas créé de commit de mon coté** depuis la dernière fois que j'étais à jour)  
  le merge va se faire en mode ***fast-forward***, on n'a pas besoin de créer un commit de fusion  
  je me retrouve sur **le même commit** que le remote

* par contre, si entre temps j'avais fait un commit de mon côté, alors là le merge va **créer un commit de fusion**  
  ça va sans dire, mais forcément le commit de fusion est créé **dans mon dépôt** bien entendu  
  on est en train de faire un `pull`, on n'est pas du tout en train d'essayer de toucher au dépôt distant  
  (dans lequel, de toutes façons, on n'a pas forcément le droit d'écrire, en plus)

+++

dans cette vidéo on va illustrer le cas où, cette fois, j'ai fait un commit de mon coté avant de `pull`:

```{code-cell}
:tags: [remove-input]

%%python
from ipywidgets import Video
Video.from_file("_static/PullDiverge.mp4", autoplay=False, loop=False)
```

### *tracking branch* (optionnel)

à ce stade de notre scénario, et pour faciliter la vie aux débutants, on peut en effet faire juste 
```bash
git pull
```
mais sachez qu'en réalité, c'est équivalent à
```bash
git pull origin main
```

c'est la notion de *tracking branch*: on a associé la branche locale `main` à la branche distante `origin/main`, du coup c'est ce qui sert quand on est sur la branche `main` et qu'on fait juste `pull`


````{admonition} c'est dans la config
:class: dropdown

les curieux peuvent regarder le contenu de `.git/config`, et observer notamment ceci
```text
[remote "origin"]
	url = git@github.com:ue12-p24/git-sandbox.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
```
````

on aura l'occasion d'en reparler très rapidement lorsqu'on aura vu le `push`
