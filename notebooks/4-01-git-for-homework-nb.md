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

# utiliser `git` pour les devoirs

vous serez également amenés à utiliser github pour rendre vos devoirs;
de cette façon votre professeur pourra avoir toujours accès à votre dernière version

````{admonition} pas de rendu par mail

cette façon de faire est largement préférable à un envoi par mail, qui demande pas mal de manipulations manuelles et fastidieuses, aussi dans la plupart des cas le rendu par mail est en général réservé aux situations exceptionnelles
````

dans tous les cas de figure (avec ou sans *starter code*):
- on vous demande de créer un **repo privé** et du coup **d'y inviter votre prof**
- le fait d'inviter le prof suffit à le prévenir qu'il y a des choses à aller collecter, pas besoin d'envoyer un mail 
- **sauf si vous avez un *slug* farfelu** sur `github.com`, car dans ce cas le prof ne pourra pas faire l'association avec votre vrai nom; laissez-lui dans ce cas un mail pour lui dire "le *slug* `PatateChaude` en fait c'est moi Jean Mineur"

+++

### devoir sans starter repo

pour les cours de début d'année, on va vous demander d'écrire des morceaux de code  
selon l'exercice, cela pourra être des notebooks, du code Python, etc...

la façon de faire dépend dans tous les cas de votre professeur, mais voici un *workflow* possible:

- au début du cours, vous créez sur github un repo qui va servir tout au long du cours
  par exemple `https://github.com/jeanmineur/numerique-homework`
  qui vous servira à exposer tous les devoirs que vous ferez pendant le cours de PE
- pour les devoirs on vous demande de **créer le repo privé**
- et ensuite pour chaque exercice:
  - vous créez un dossier dans le repo, avec un nom qui désigne l'exercice, par exemple `mandelbrot/` (le prof vous donnera peut-être une consigne précise à ce sujet)
  - vous faites add / commit pendant que vous codez
  - et quand vous êtes satisfait vous faites `push`

quelques conseils dans ce cas de figure:

- installez votre repo local `numerique-homework` dans un dossier qui se situe **en dehors** - typiquement, à coté - du repo du cours
  (il est possible de le mettre dans un sous-dossier, mais l'expérience prouve que les débutants ont tendance à s'emmêler les pinceaux avec ce genre de setup)
- cela signifie que vous aurez un layout qui ressemblera à
  ```console
  /Users/jeanmineur/git/ue12-p24/
  /Users/jeanmineur/git/ue12-p24/numerique/           # <- le repo du cours
  /Users/jeanmineur/git/ue12-p24/numerique-homework/  # <- le repo des exercices
  ```
- et du coup pour faire un TP:
  - vous commencez par aller (avec `cd`) dans le dossier `git/ue12-p24/numerique-homework`
  - vous y créez le dossier de l'exercice, genre
    `mkdir mandelbrot/`
  - vous y allez
    `cd mandelbrot`
  - et à cet endroit vous copiez les éventuels artefacts de l'exercice, .zip ou .py ou autres
  - et ensuite vous n'avez plus qu'à faire les *add* / *commit* / *push*

+++

### devoir avec *starter repo*

on pourra également vous donner parfois un TP qui se présente sous la forme d'un repo git déjà constitué  
pour avoir une idée vous pouvez aller voir un exemple d'un tel repo ici <https://github.com/ue22-p24/web-xkcd>  

c'est finalement plus simple ici, puisqu'il y a déjà un repo constitué, mais voici tout de même quelques conseils

* comme ci-dessus, c'est sans doute une bonne idée de mettre votre repo de devoirs **à coté du cours**  
  e.g.
  ```
  /Users/jeanmineur/git/ue22-p24/web/
  /Users/jeanmineur/git/ue22-p24/web-xkcd
  ```

* il s'agit donc de dupliquer le repo de départ, avant d'y ajouter votre contribution  
  pour cela deux options sont possibles

  1. option *fork*: c'est **le plus simple**: vous faites un *fork* du repo en question dans votre espace github
  1. option "manuelle": vous clonez le repo sur votre ordi, puis vous créez un repo sur github à partir de ce clone

dans les deux cas à nouveau, on vous demande de faire un **repo privé**, aussi **pensez à y inviter votre prof** !  
en détails ça donnerait ceci

#### option *fork*

```{image} media/fork-clone-push-pull-request.svg
:align: center
:width: 500px
```

- vous allez sur la page du repo - e.g. <https://github.com/ue22-p24/web-xkcd> - et vous cliquez sur *Fork*
- cela crée pour vous une copie ici <https://github.com/jeanmineur/web-xkcd>
- que vous clonez sur votre ordi en faisant, comme d'habitude (copiez-collez l'URL depuis github)
  ```bash
  git clone git@github.com:jeanmineur/web-xkcd.git
  ```
- à ce stade vous devez rendre le fork *private* (car comme vous avez *fork* un repo public, le *fork* est public aussi); ça se passe dans la rubrique *Settings*
- et il vous faut inviter le prof

#### option "manuelle"

- vous commencez par cloner le repo
  ```
  git clone git@github.com:ue22-p24/web-xkcd.git
  ```
- vous allez sur github créer un repo:
  - de préférence utilisez le même nom
  - choisissez un repo privé
  - choisissez de **ne pas ajouter un README** - comme ça le repo sur github sera vraiment vide, et c'est ce qu'on veut car voous avez déjà un repo...
- sur la page correspondant à ce nouveau repo sur github, on vous montre comment faire pour ... *…or push an existing repository from the command line*, vous copiez-collez cela
- enfin pensez à inviter le prof

à ce stade, que vous ayez choisi l'une ou l'autre option, vous n'avez plus qu'à *push* vos commits pour que le prof y ait accès
