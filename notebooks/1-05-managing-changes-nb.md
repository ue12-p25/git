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
nbhosting:
  title: "diff\xE9rences pendantes"
---

License CC BY-NC-ND, Thierry Parmentelat & Valérie Roy

```{code-cell}
%%python
from IPython.display import HTML
HTML(filename="_static/style.html")
```

# différences pendantes

+++

## on contextualise

nous avons vu précédemment qu'un dépôt git de travail se compose des trois morceaux : fichiers / index / commits  
on a vu qu'un dépôt *propre* est un dépôt dans lequel ces trois étages ont des contenus identiques  
et on a vu comment "faire avancer" une modification, en deux phases :

* d'abord on la met dans l'index avec `add`
* puis dans un commit avec `commit`

````{admonition} rappel: add ligne par ligne
:class: tip dropdown

souvenez-vous qu'on peut

* ajouter d'un seul coup toutes les modifications d'un fichier avec  
  `git add nom-du-fichier`
* mais aussi, ajouter très finement - i.e. ligne par ligne  
  dans ce cas il vaut mieux utiliser une GUI - [voir plus bas, c'est faisable par exemple avec vscode](label-guis)  
  pourquoi on aurait envie de faire ça ? pour ne pas mélanger des modifications qui n'ont rien à voir dans un même commit
````

mais cela, ça ne couvre que le cas idéal où on ne se trompe jamais, où on ne change pas d'avis  
mais dans la vraie vie bien sûr, ce n'est pas comme ça que ça fonctionne, et on a besoin de pouvoir rétropédaler

+++

## terminal ou GUI

dans ce notebook on résume les commandes utiles pour visualiser / gérer / abandonner les différences pendantes

* dans la **première partie** on parle des commandes à lancer dans les terminal
  par contre, on ne donne pas le mode d'emploi détaillé de toutes les commandes, à vous de chercher dans la documentation

* on peut tout faire depuis le terminal, mais pour gérer finement les différences (ligne à ligne notamment), c'est souvent beaucoup plus pratique à partir d'une GUI, c'est ce qu'on va voir dans la **deuxième partie**

+++

## depuis le terminal

+++

### le workflow usuel

dans un premier temps on revoit, sous une forme visuelle, les commandes qu'on a déjà pratiquées

+++

#### un dépôt propre

on utilisera ce type de présentation dans la suite :

```{image} media/kn-lifecycle-1-clean.svg
:align: center
```

+++

#### `git status` et `git diff`

en général le dépôt n'est pas propre, on peut voir les (deux familles de) différences avec ces 2 commandes

```{image} media/kn-lifecycle-2-status-diff.svg
:align: center
```

+++

***

+++

#### j'utilise mon éditeur

```{image} media/kn-lifecycle-3-editor.svg
:align: center
```

le changement que je sauve δ s'ajoute en fait aux différences existantes, qui s'accumulent évidemment.

+++

#### `git add`

```{image} media/kn-lifecycle-4-add.svg
:align: center
```

la différence apparait maintenant dans la deuxième zone (*staged changes*)

+++

#### `git commit`

```{image} media/kn-lifecycle-5-commit.svg
:align: center
```

on crée le nouveau commit sur la base du contenu de l'index, du coup les deux (l'index et le dernier commit) sont maintenant égaux

+++ {"tags": []}

### pour revenir en arrière

````{admonition} comment lire cette partie
:class: tip

s'agissant de cette partie, inutile de retenir tous les détails, se souvenir que ça existe pour pouvoir y revenir en cas de besoin

d'autant d'aileurs que, la plupart du temps, on utilisera plutôt une GUI (voir plus bas)
````


jusqu'à maintenant on a travaillé *"de gauche à droite"*  
à présent on va voir des commandes nouvelles, qui permettent principalement de défaire la progression des changements", et donc d'aller *"de droite à gauche"*

**attention** du coup car en faisant ça :

* d'une part cela peut causer des changements dans nos fichiers et/ou l'index
* au point que certaines d'entre elles **peuvent nous faire perdre du contenu**

à utiliser avec précaution donc; mais ça a une vraie utilité !

````{admonition} perdre du contenu ?
:class: warning

dans quelles situations on peut avoir envie de perdre du contenu ?

typiquement, on met en chantier une feature, et au bout d'une heure on se dit, non vraiment ça n'est pas du tout comme ça qu'il fallait prendre le problème

ou encore, pendant le debug on a ajouté 250 instructions `print()`, qu'on veut enlever; plutôt que de les enlever une par une, c'est plus malin de mettre les changements utiles dans l'index, et de jeter les autres différences
````

+++ {"tags": []}

#### `git restore --staged`

pour annuler le `add` : si un changement a été promu dans l'index, on peut le déclasser

```{image} media/kn-lifecycle-6-restore-staged.svg
:align: center
```

+++ {"tags": []}

#### `git restore`

pour jeter les changements non indexés

```{image} media/kn-lifecycle-7-restore.svg
:align: center
```

+++ {"tags": []}

#### `git restore --worktree --staged`

pour se mettre inconditionnellement sur un commit, avec un dépôt propre

```{image} media/kn-lifecycle-8-restore-worktree-staged.svg
:align: center
```

+++

`````{admonition} note historique: avant git restore
:class: dropdown caution

````{div}
dans les versions anciennes de git, i.e. avant que l'on introduise `git restore`, on devait utiliser à la place ceci

| pour faire | avant restore | avec restore |
|-:|:-:|:-|
| défaire un add | `git reset` | `git restore --staged` |
| jeter les changements non indexés | `git checkout` | `git restore` |
| défaire les deux familles de changements | `git reset --hard` | `git restore --staged --worktree` |
````
`````

+++ {"tags": []}

### refaire un commit avec `git commit --amend`

vous venez de faire un commit mais il est raté !  
en général ça peut venir

1. soit du texte du message qu'on a tapé trop vite
1. soit c'est plus profond, c'est le contenu
1. plus rarement c'est le nom de l'auteur qui est faux

dans tous les cas, pas de panique, `git commit --amend` est fait pour ça

le principe c'est de:

* refaire un commit qui a le·s même·s parent·s que le commit courant
* dans lequel on a **aussi** fait entrer l'index courant
* et en redemandant le message bien entendu

si bien que, selon le cas qui vous concerne parmi ceux listés plus haut, vous pouvez:

1. pour récrire votre message, refaites simplement  
   `git commit --amend`  
   qui vous ouvrira votre éditeur avec le message du commit courant

2. si c'est plus profond:
   * ajoutez dans l'index les changements qui manquent au commit courant
   * avant de faire ici encore `git commit --amend`
   * vous pouvez même ajouter l'option `--no-edit` si le message était correct

3. pour le dernier cas, faites ceci  
   `git commit --amend --author="Jean Dupont <jean.dupont@example.com>"`

````{admonition} on ne modifie pas le commit

remarquez qu'avec `--amend` on ne **modifie pas** le commit courant (les commits sont **immutables**), on en **crée** simplement **un nouveau**  
le premier reste dans le repo, mais généralement on ne le "voit plus" car il est inatteignable, et il sera nettoyé au bout de quelque temps
````

+++ {"tags": []}

(label-guis)=
## utiliser une GUI

signalons enfin qu'il existe plein d'outils graphiques pour simplifier l'utilisation de git, et notamment, surtout au début, pour

* avoir en permanence une **représentation bien à jour** de l'état du dépôt
* gérer plus **simplement le workflow** qu'on a détaillé plus haut  
  (ajouter, annuler l'ajout, jeter complètement, les changements) et cela finement (ligne par ligne si nécessaire)
  sans avoir à mémoriser toutes les commandes pour le faire

voici rapidement quelques outils gratuits qui sont bien pratiques

+++

### vs-code

on a déjà présenté l'extension git dans vs-code, qui a l'avantage d'être intégrée nativement, mais peut vite s'avérer limitée  

pour utiliser l'extension native 'git', rien à installer, il faut simplement cliquer sur l'extension dans la barre de gauche
voici comment on navigue dans les différences avec vs-code

```{image} media/vscode-changes.png
:align: center
```

+++

si en plus vous installez l'extension 'git graph', vous pourrez aussi voir le graphe des commits directement dans vs-code

```{image} media/vscode-gitgraph-history.png
:align: center
```

+++

### Sourcetree

l'outil `Sourcetree` (malheureusement pas supporté sous linux) visualise les deux classes de différences comme ceci

```{image} media/sourcetree-changes.png
:align: center
```

+++

voici une autre vue qui visualise aussi le graphe des commits

```{image} media/sourcetree-history.png
:align: center
```

+++

### GitKraken

l'outil GitKraken, qui est disponible cette fois sur linux, les présente quant à lui comme ceci

```{image} media/gitkraken-changes.png
:align: center
```

+++

ici encore l'outil sait afficher le graphe des commits

```{image} media/gitkraken-history.png
:align: center
```
