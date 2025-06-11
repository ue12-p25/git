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

# synchro entre dépôts : pousser

````{admonition} lire les vidéos dans Jupyter lab
:class: tip

ce notebook contient des vidéos; si vous le lisez dans Jupyter, pour que les vidéos s'affichent:  
assurez-vous d'exécuter toutes les cellules avec *Run* -> *Run All Cells*
````

+++

## on contextualise

+++

### exporter avec `git push`

maintenant qu'on a bien compris comment on peut aller chercher des nouveautés depuis un dépôt distant,  
on va voir à présent **dans l'autre sens** comment on peut **exporter des choses** sur un dépôt distant

ici c'est facile il n'y a qu'une seule commande à connaître, et c'est… devinez un peu

oui, c'est `git push`

le principe est presque exactement le réciproque de `git pull`, avec toutefois **deux grosses différences**

+++

### on a besoin de droits particuliers

première grosse différence avec le `pull`:  
nous essayons de **faire des modifications** dans le dépôt distant, et du coup il va nous falloir **les droits en écriture** !

c'est un sujet qu'on a déjà effleuré dans les slides d'introduction où, souvenez-vous, on avait vu que Bob pouvait collaborer avec Alice si :

* soit si elle lui donnait les droits d'écrire dans son dépôt,
* soit en passant par son *fork*, dans lequel il peut écrire

j'en profite pour signaler que le *fork* est une notion introduite par la surcouche github, et non pas une notion native de git,  
on n'aura pas le temps d'approfondir, mais à ce stade vous devez avoir deviné l'idée générale

+++ {"jp-MarkdownHeadingCollapsed": true}

### un push ne peut faire qu'un fast-forward

l'autre différence importante, c'est que par sécurité on a décidé qu'avec `git push` on peut **seulement** faire des merge ***fast-forward***

pourquoi ça ?  
l'idée c'est simplement que, si on se retrouve à devoir créer un commit de fusion à distance, il y a le risque de se trouver en présence de conflits; et dans ce cas-là une intervention manuelle est nécessaire; mais on n'a pas accès aux fichiers à distance pour résoudre le conflit,  
bref on a décidé que c'était possiblement dangereux, et donc pas une bonne idée

sans discuter plus avant de la pertinence de ce choix, voyons d'abord comment tout cela fonctionne

+++

## le `push` est pratiquement l'inverse du `pull`

cette vidéo décortique le fonctionnement de `push` dans un cas simple

```{code-cell}
:tags: [remove-input]

%%python
from ipywidgets import Video
Video.from_file("_static/Push.mp4", autoplay=False, loop=False)
```

## mais attention le push peut coincer !!!

dans la suite de la vidéo on envisage un cas (**très fréquent**) où le push **ne peut pas se faire** avant que l'on ne fasse d'abord un `pull`

```{code-cell}
:tags: [remove-input]

%%python
from ipywidgets import Video
Video.from_file("_static/NeedPull.mp4", autoplay=False, loop=False)
```

## *tracking branch* (suite et fin, toujours optionnel)

pour les avancés, on peut gérer la *tracking branch* avec `push`

````{admonition} set-upstream
:class: dropdown warning

c'est le propos de l'option `--set-upstream` -- en abrégé `-u` - de `push`, qui permet d'associer une branche locale à une branche distante

```bash 
# par exemple si on fait ceci une fois
# on pousse la branche local devel sur la distante `devel`
git switch devel
git push --set-upstream origin devel
# et après ça quand on est sur devel on a juste besoin de faire
git push
# et ça va bien aller pousser sur le devel distant
```
````

+++

## conclusion

à part ces deux différences (besoin de permission, et refus de créer un commit de fusion), le fonctionnement de `push` est le symétrique de celui de `pull`
