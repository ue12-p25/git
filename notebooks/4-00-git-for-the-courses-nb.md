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

# utiliser `git` pour les cours

+++

on vous conseille de mettre **les notebooks et tout le contenu du cours sur votre
ordinateur**; pour cela la démarche à suivre est indiquée ci-dessous

pour rappel également, dans la vidéo suivante on a fait une micro-démo
de l'environnement en action
<https://www.youtube.com/watch?v=i_ZcP7iNw-U>

attention, nous mettons régulièrement à jour les notebooks chaque semaine; du
coup pour garder votre travail **et** une version à jour, il faut *pull* le dépôt
distant; on aborde aussi cette étape [un peu plus bas](label-pull-course)

+++

## configurer `git`

+++

reportez-vous au cours d'introduction pour vous assurer, si besoin, que vous
avez bien configuré git

pour rappel, il est nécessaire de configurer

* vos nom/prénom et adresse e-mail
* l'éditeur à utiliser lors des commits (pour nous: vs-code)
* la clé ssh
* et quelques autres détails...

+++

## au début du cours

### cloner les notebooks sur son ordinateur

* aller sur l'interface `Git Bash`
* se déplacer (avec les commandes `pwd` et `ls` et `cd`) dans le dossier souhaité
* une fois dans le dossier où vous souhaitez cloner les notebooks  
  (par exemple `/Users/jeanmineur/git/ue12-p24`), faire

  ```bash
  git clone git@github.com:ue12-p24/numerique.git
  ```
  pour trouver la bonne URL, regardez comment on fait dans la vidéo  
  en faisant bien attention de choisir le mode `SSH` comme ceci:

  ```{image} media/github-choose-ssh.png
  :width: 500px
  :align: center
  ```

* un dossier va être créé, ici il s'appelle `numerique`  
  (si vous préférez un autre nom, ajoutez le à la commande ci-dessus)

* dans le dossier choisi, vous allez trouver tout le contenu du cours, y compris
  les  notebooks ! ils sont généralement dans un sous-dossier `notebooks/`

en naviguant sur github et plus particulièrement sur la page de l'orga
ue12-p24 (<https://github.com/ue12-p24/>), vous pouvez voir l'ensemble des
répertoires des cours d'informatique que vous avez eu jusque-là ! 

````{admonition} et au second semestre ?
au second semestre les cours seront dans l'orga <https://github.com/ue22-p24/>
````

+++

### installer les dépendances

* *optionnel*: vous pouvez aussi créer un environnement virtuel en lui donnant
  un nom (et éventuellement la version de `python` que vous voulez);
  ici je choisis de créer un environnement virtuel qui s'appelle aussi `numerique`

  ```bash
  conda create -n numerique python=3.12
  ```

* *optionnel*: si vous utilisez un système d'environnements virtuels, prenez
  soin de sélectionner le bon; il faut le faire à chaque fois qu'on crée un nouveau terminal,
  par exemple

  ```bash
  conda activate numerique
  ```

* dans le dossier du cours se trouve un fichier `requirements.txt`  
  allez dans ce dossier et tapez

  ```bash
  pip install -r requirements.txt
  ```

* a minima il vous faut avoir installé `jupyter` et `jupytext`  
  qui devraient en principe être installés à ce stade; si ce n'est pas le cas,
  faites

  ```bash
  pip install jupyter jupytext
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

avant chaque nouveau cours, comme le prof a pu faire quelques petits changements, il est utile de mettre à jour votre dossier de cours; et pour cela:

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
