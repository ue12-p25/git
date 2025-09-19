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
---

# cloner un cours

+++

pour certains cours, on vous conseille de mettre **tout le contenu du cours sur
votre ordinateur**; pour cela la démarche à suivre est indiquée ci-dessous

```{admonition} et si ça évolue ?
:class: dropdown

nous mettons régulièrement à jour les cours; du coup
il peut être nécessaire de mettre le cours à jour **tout en conservant votre
travail**, [c'est ce qu'on aborde dans la dernière partie ci-dessous](label-pull-course)
```

```{admonition} une vidéo de présentation
:class: dropdown tip

pour rappel, dans la vidéo suivante on a fait une micro-démo
de l'environnement en action
<https://www.youtube.com/watch?v=i_ZcP7iNw-U>
```

+++

## configurer `git`

en principe on a configuré git en début d'année  
mais en cas de besoin reportez-vous [au cours d'introduction](https://intro.info-mines.paris/1-1-installations/#-configuration-git)

+++

## au début du cours

### cloner un cours sur son ordinateur

ou n'importe quel repo sur github - ça marche aussi pour certains TPs:

* dans un terminal `Git Bash`
* se déplacer (avec les commandes `cd`, `pwd` et `ls`) dans le dossier souhaité
* une fois dans le bon dossier, il va falloir faire un `git clone`  
  et pour trouver le bon URL, vous
  * allez sur la page du repo sur github, [par exemple ici](https://github.com/ue12-p25/numerique)
  * vous copiez dans le presse-papier l'URL du repo - en prenant bien SSH  
  ```{image} media/github-choose-ssh.png
  :width: 500px
  :align: center
  ```
  * et vous utilisez cela pour taper une commande qui ressemble à ceci
  ```bash
  #         cette partie est copiée depuis github.com
  #         ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
  git clone git@github.com:ue12-p25/numerique.git
  ```

* un dossier va être créé, ici il s'appelle `numerique`  
  (si vous préférez un autre nom, ajoutez le à la commande ci-dessus)

* dans le dossier choisi, vous allez trouver tout le contenu du cours; les notebooks, lorsqu'il y en a , sont généralement dans un sous-dossier `notebooks/`

### cours disponibles

en naviguant sur github et plus particulièrement [sur la page de l'orga
ue12-p25](https://github.com/ue12-p25/), vous pouvez voir l'ensemble des
répertoires des cours d'informatique que vous avez eu jusque-là ! 

````{admonition} et au second semestre ?
au second semestre les cours seront dans l'orga <https://github.com/ue22-p25/>
````

### installer les dépendances

````{admonition} optionnel: un environnement virtuel
:class: dropdown

* *optionnel*: vous pouvez créer un environnement virtuel en lui donnant
  un nom (et éventuellement la version de `python` que vous voulez);
  ici je choisis de créer un environnement virtuel qui s'appelle aussi `numerique`

  ```bash
  conda create -n numerique python=3.13
  # ou bien, pour les cours de S2 on pourra faire
  conda create -n frontend python=3.13 conda-forge::nodejs=24
  ```

* *optionnel*: si vous utilisez un système d'environnements virtuels, prenez
  soin de sélectionner le bon; il faut le faire à chaque fois qu'on crée un nouveau terminal,
  par exemple

  ```bash
  conda activate numerique
  ```
````

* si le dossier du cours contient un fichier `requirements.txt`  
  allez dans ce dossier et tapez

  ```bash
  pip install -r requirements.txt
  ```

+++

## lire le cours

* toujours dans le dossier du cours, en faisant

  ```bash
  jupyter lab
  ```

  vous lancez le serveur et ainsi pouvez lire les notebooks

+++

(label-pull-course)=
## mettre à jour sa version locale

avant chaque nouveau cours, comme le prof a pu faire quelques petits changements, il peut être utile de mettre à jour votre dossier de cours; et pour cela:

* lancer `Git Bash`
* vous rendre dans le dossier local où vous avez cloné le répertoire  
  (la commande `git status` devrait fonctionner à cet endroit)

* faire `git pull`
* il est possible que tout fonctionne bien :)
* néanmoins, si jamais **vous avez modifié certains fichiers**, il vous faudra
  d'abord enregistrer vos modifications:

  ```bash
  git add -u
  git commit -m "j'enregistre mes modifications"
  ```

  (le `-u` signifie "*ajouter seulement les fichiers que j'ai modifiés*")

* après cela, refaites `git pull`

+++

###  en cas de conflit

si au moment du pull, vous voyez ce message:  
>  `automatic merge failed; fix conflicts and then commit the result.`

cela signifie qu'**il y a des conflits** (par exemple, vous avez fait
*localement* dans un fichier des modifications **au même endroit** que des
changements faits par le prof); normalement c'est assez
rare, mais si c'est le cas, il va vous falloir régler les conflits...  

deux options à ce stade

#### chicken out

tout ça vous fait peur, vous voulez juste abandonner:

```bash
git merge --abort
```

et vous revenez à votre commit, *no harm done*  
(et rien ne vous empêche de recommencer plus tard)

#### résoudre les conflits

sinon voici comment on résoud les conflits:

* après le `git pull`, faites un `git status`
* les fichiers en rouge dans la catégorie `unmerged paths` correspondent à ceux
  qui sont en conflit.

* ouvrez les fichiers correspondants dans vs-code.
  * les blocs en conflits (potentiellement plusieurs par fichier) ressemblent à ça :

    ```text
    <<<<<<< HEAD
    votre code
    =======
    le code distant
    >>>>>>> origin/main
    ```

* vous devez alors choisir le code final que vous gardez (soit en ne laissant
  qu'un seul des deux blocs dans le fichier, soit en faisant un mixte des deux);
  débarrassez-vous aussi des lignes-balises en `<<<` et `===` et `>>>`

* une fois tous les conflits de tous les fichiers résolus, vous pouvez faire
`git add` des fichiers en question, et enfin

  ```bash
  git commit --no-edit
  ```

  Et normalement vous avez maintenant la version locale à jour !  
  (le `--no-edit` sert à ne pas passer dans l'éditeur, il n'est vraiment pas
  utile ici de mettre un message spécifique)


si vous avez des questions, n'hésitez pas à nous contacter (ou à chercher sur
internet en anglais).
