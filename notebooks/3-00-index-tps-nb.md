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
  title: quelques TPs
---

# index des TPs

quelques TPs pour pratiquer `git`

+++ {"tags": []}

## tp-add-by-lines

````{admonition} les changements ligne par ligne
:class: seealso

quand on a fait plusieurs modifications distinctes, et qu'on veut les grouper en plusieurs commits, il faut pouvoir gérer **finement les ajouts dans l'index**, c'est-à-dire au niveau du bloc ou de la ligne

<https://github.com/ue12-p25/git-tp-add-by-lines>
````

+++ {"tags": []}

## tp-conflict

````{admonition} résoudre un conflit
:class: seealso

un tp à faire individuellement  
on crée délibérément un conflit pour savoir reconnaître les symptômes, et s'entrainer à résoudre le conflit

<https://github.com/ue12-p25/git-tp-conflict>
````

+++

## tp-pending-changes

````{admonition} faire et défaire
:class: seealso

travail individuel

1. créer un repo, **ajouter dedans un commit** avec un `README.md` contenant une seule ligne (typiquement on un titre en markdown)
1. faites une modification (ajouter du texte) avec vs-code
1. **ajoutez-la dans l'index**
1. faites une autre modification (ajouter du texte), toujours avec vs-code
1. à ce stade vous avez deux classes de modifications: staged ou non  
   observez-les avec `git status` et `git diff` (ou équivalent dans vs-code)
1. vous changez d'avis, vous voulez **défaire l'action que vous aviez faite dans 3.**  
(c'est-à-dire retirer la modife de l'index mais pas la jeter complètement)
1. pareil que 5., assurez-vous que vous arrivez bien à visualiser l'état du repo; normalement vous n'avez plus qu'une seule classe de changements, *non staged*
1. enfin vous changez envore d'avis et vous voulez **jeter complètement les modifications** en souffrance, vous les jetez complètement
1. on vérifie visuellement qu'il n'y a plus de modification pendante
````

````{admonition} on peut envisager deux versions de ce TP
:class: warning
```{admonition} 1. on fait **tout sous vs-code**
c'est sans doute la plus simple:
  * pour 3., il faut chercher une icone **+**
  * et assez logiquement pour 6, il faut chercher l'icone **-**
  * pour 8. le verbe est *discard*
```
```{admonition} 2. dans le terminal
* voyez le notebook **`1-05`** ***"différences pendantes"*** pour les commandes à utiliser
```
````

+++

## tp-amend

````{admonition} oops, j'ai raté mon commit
travail individuel

1. créer un repo, ajouter un commit avec un `README.md` vide
1. ajouter du texte dans le `README.md`, mettez ça dans un commit
1. grâce à `git commit --amend`, refaites le commit, et pour cela

  * retouchez le `README.md` sous vs-code
  * ajoutez la nouvelle modife avec `git add`
  * refaites le commit avec `git commit --amend`
1. vérifiez que vous avez bien 2 commits et pas 3, et que le deuxième contient bien ce qu'il faut

````

+++ {"tags": []}

## tp-clone-pull

````{admonition} tirer - pousser: dans le bon ordre
:class: seealso

nos cours sont publiés sur github, et vous les **clonez** chez vous  
puis pour le cours suivant, le prof publie une **nouvelle version** du cours

comment faire pour réconcilier votre copie locale avec la nouvelle version du cours ?

et que se passe-t-il alors exactement dans votre copie locale, si vous avez vous-même fait des changements dans les notebooks ?

ce TP demande une courte préparation spécifique par groupe  
une fois que c'est prêt vous devrez visiter une URL **dans le genre de**  
*`https://github.com/ue12-p25/git-tp-clone-pull-groupe3`*  

```{admonition} à faire par le prof
:class: dropdown

les instructions pour préparer le TP sont ici <https://github.com/ue12-p25/git-tp-clone-pull-for-teacher/blob/main/README-teacher.md>
```
````

+++ {"tags": []}

## tp-killing-push

````{admonition} vous n'arrivez pas à pousser ?
:class: seealso

vous travaillez à plusieurs dans un repo, et vous n'**arrivez pas à pousser un commit** ?  
c'est sûrement que quelqu'un d'autre a poussé avant vous…

<https://github.com/ue12-p25/git-tp-killing-push>
````

+++ {"tags": []}

## tp-teamwork

````{admonition} en équipe
:class: seealso

un tp plus complet où on simule un travail en groupe  
à faire en groupes de 3 ou 4

<https://github.com/ue12-p25/git-tp-teamwork>
````

+++ {"tags": []}

## tp-pull-request-fork

un TP à faire à deux  

* élève `A` crée un repo sur github, avec du contenu; le repo est **public**
* pour la suite, c'est essentiellement élève `B` qui bosse, élève `A` peut profitablement regarder :)
* élève `B` clone le repo, fait une modification et la met dans un commit
* élève `B` essaie de pousser son nouveau commit dans le github de `A`, mais échoue car il n'a pas les droits
* élève `B` demande à github de lui créer **un *fork***
* élève `B` pousse son commit dans son *fork* (il a le droit cette fois)
* élève `B` crée (dans le repo de `A`) **un *pull request***
* élève `A` consulte le *pull request*, et accepte (merge) le changement
* on vérifie que la modification de `B` est bien dans le repo de `A`

on recommence en inversant les rôles...

````{admonition} indice
:class: tip

dans l'écran de création du PR, il y a un bouton ***"compare across forks"*** qu'il faut cliquer pour pouvoir créer une PR entre deux repos distincts
````

+++

## tp-pull-request-single-repo

un TP à faire à deux  

* élève `A` crée un repo sur github, avec du contenu; le repo est **public**
* pour la suite, c'est essentiellement élève `B` qui bosse, élève `A` peut profitablement regarder :)
* élève `B` clone le repo.
* élève `B` ouvre une nouvelle **branche** `feature-eleve-b` et fait une modification et la met dans un commit
* élève `B` essaie de pousser son nouveau commit dans le github de `A`, mais échoue car il n'a pas les droits
* élève `A` donne des droits à l'élève `B` : via Settings/Collabateurs sur le repository du projet. Trouver l'option *Manage access*/*Add people*
* élève `B` accepte l'invitation pour travailler sur le repository de l'élève `A`
* élève `B` pousse son commit et sa branche sur le repository de l'élève `A`
* élève `B` crée (dans le repo de `A`) **un *pull request***
* élève `A` consulte le *pull request*, et accepte (merge) le changement
* on vérifie que la modification de `B` est bien dans le repo de `A`

* élève `A` peut effectuer la même procedure en commitant sur la branche qu'il créé `feature-eleve-a`

Certains workflows imposent que tous les changements soient fait via une *Pull Request*. On souhaite alors 'protéger' la branche principale `main` contre les commits directs. Pour ce faire :

* élève `A` va dans les *Settings/Branches* du repository et click sur l'option *'Add classic branch protection rule'*. La branche à protéger est '`main`'. Séléctionner l'option *'Require a pull request before merging'* et *'Require a pull request before merging'*
* élève `A` et l'élève `B` essaient de pousser un changement/commit directement sur `main`. Que se passe-t-il ?

+++

## tp-class-text

un TP à faire à toute la classe

ce TP demande une courte préparation spécifique par groupe  
une fois que c'est prêt vous devrez visiter une URL **dans le genre de**  
*`https://github.com/ue12-p25/git-tp-class-text-groupe3`*  

````{admonition} à faire par le prof
:class: dropdown seealso

à destination des avancés, et pour illustrer le cours, voici comment le prof peut faire la préparation pour cet exo, avec le bon numéro de groupe *of course*

```bash
  # cloner localement le repo de référence
git clone git@github.com:ue12-p25/git-tp-class-text-template.git
  # aller dedans
cd git-tp-class-text-template
  # créer le repo sur github - il faut avoir les droits
gh repo create --public ue12-p25/git-tp-class-text-groupe3
  # ajouter un remote qui pointe vers ce nouveau repo (vide pour l'instant)
git remote add my-group git@github.com:ue12-p25/git-tp-class-text-groupe3.git
  # pousser dedans
git push my-group main
```
````
