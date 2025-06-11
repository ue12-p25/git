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
  title: cherry-pick & revert
---

License CC BY-NC-ND, Thierry Parmentelat & Valérie Roy

```{code-cell}
%%python
from IPython.display import HTML
HTML(filename="_static/style.html")
```

# cherry-pick & revert

ce notebook est complètement **optionnel**

+++

## use case 1

avant de voir le cherry-pick dans le détail, donnons d'abord un *use case* classique  
on en profite d'ailleurs pour introduire la notion de tag, que l'on n'a pas encore eu l'occasion de voir jusqu'ici

vous êtes en charge de l'évolution et la maintenance d'un logiciel  
le développement de la future version 4 se fait sur la branche `main`
mais la plupart des clients utilisent une version stable 3.0 
et le reste des clients n'a pas eu le temps d'upgrader et utilisent la 2.2

typiquement dans ce cas de figure on va créer:
- deux branches `3.x` et `2.x` pour suivre les évolutions de la version 3
- autant de tags que de versions publiées, ici par exemple 2.0, 2.1, 2.2, 3.0

  ````{admonition} pour crér un tag
  c'est très facile, ça se fait avec `git tag` comme par exemple
  ```bash
  git tag 2.0 <le-commit>
  ```
  ````

le repo ressemble à ceci - (le carré représente le commit courant; de plus, imaginez entre les versions 2.0 et 3.0 un bien plus grand nombre de commits..)

```{mermaid}
%%{init: { 'logLevel': 'debug', 'theme': 'base', 'gitGraph': {'showBranches': true}} }%%

gitGraph
    commit
    commit
    commit
    branch 2.x order: 2
    commit tag: "2.0"
    commit tag: "2.1"
    commit tag: "2.2"
    checkout main
    commit
    commit
    commit
    commit
    branch 3.x
    commit tag: "3.0"
    checkout main
    commit
    commit id: "tedious and fragile feature"
    commit type: REVERSE id: "super important BUGFIX"
    commit
    commit type: HIGHLIGHT
```

+++

## `cherry-pick`

dans ce genre de cas, il arrive qu'on corrige sur `main` un bug important (voyez le commit marqué d'une croix ci-dessus); et du coup on veut pouvoir facilement appliquer ce fix sur les deux branches - mais bien entendu sans prendre les autres commits qui sont sur `main`

c'est exactement que sert `cherry-pick`; ce qu'on ferait dans ce cas-là ce serait

```bash
git switch 3.x
git cherry-pick <le-hash-du-bugfix>
git switch 2.x
git cherry-pick <le-hash-du-bugfix>
# et pour se remettre sur main
git switch main
```

on le voit, cherry-pick nous permet d'appliquer **seulement un commit** sur la branche courante

````{admonition} notes
:class: note

* on se rend compte ici pourquoi on a vraiment intérêt à faire des commits petits et cohérents !
* bien entendu, il n'y a pas de garantie que ça fonctionne, surtout si le code sur `main` a beaucoup changé depuis la branche
* à  nouveau ici, dans la phrase "appliquer un commit" on fait un abus de langage, on devrait dire, appliquer la différence entre le commit et son parent
````

en tous cas si ça fonctionne, après

```{mermaid}
gitGraph
    commit
    commit
    commit
    branch 2.x order: 2
    commit tag: "2.0"
    commit tag: "2.1"
    commit tag: "2.2"
    commit type: REVERSE id: "BUGFIX backporté sur 2.x"
    checkout main
    commit
    commit
    commit
    commit
    branch 3.x
    commit tag: "3.0"
    commit type: REVERSE id: "BUGFIX backporté sur 3.x"
    checkout main
    commit
    commit id: "tedious and fragile feature"
    commit id: "super important BUGFIX"
    commit
    commit type: HIGHLIGHT
```

(ne pas faire attention aux hashes, qui ne sont pas les mêmes que dans le premier diagramme...)

+++

## `revert`

La commande `revert` fonctionne d'une manière assez voisine à `cherry-pick`, sauf que `revert` va appliquer le commit **à l'envers**, c'est-à-dire avec **l'objectif de le défaire**

ça s'utilise donc dans des contextes très différents de notre use case 1

+++

## use case 2

typiquement on pense à `revert` dans le cas où on a créé un commit, puis on se rend compte que ce n'était pas une si bonne idée que ça

imaginons qu'on est dans cet état

```{mermaid}
gitGraph
    commit
    commit
    commit id: "was good"
    commit id: "not a good idea" type:HIGHLIGHT
```

on a le choix entre deux stratégies trés différentes

+++

### supprimer complètement toute trace du dernier commit

dans ce cas, on ferait  
`git reset --hard HEAD^`

````{admonition} **ATTENTION**
:class: error

* **attention** car ça remet à la fois les fichiers, l'index et le commit à l'état du commit n-1, c'est donc **très intrusif**
* et aussi, essayez d'imaginer les conséquences de cette idée si vous avez déja poussé le "not a good idea" sur par exemple github..
````

mais bon, admettons que tout est clair, si on fait ça on se retrouve avec 

```{mermaid}
gitGraph
    commit
    commit
    commit id: "was good" type:HIGHLIGHT
```

+++

### faire un nouveau commit qui défait le dernier

du coup il y a autre alternative, qui consiste à enregistrer le fait qu'on a essayé ça et que ça n'a pas marché  
c'et-à-dire à remettre un nouveau commit qui revient en arrière  
et pour faire ça on ferait simplement
`git revert HEAD`

en effet, comme on l'a déjà mentionné la logique de `git revert` c'est un peu celle de cherry-pick, mais à l'envers  
ici je vais défaire le commit courant, encore un abus de langage: je vais appliquer le changement entre `HEAD` et son parent, mais à l'envers

puisqu'on crée un nouveau commit, git revert va nous demander un message, disons qu'on met "undo the wrong idea", et dans ce cas de figure on se retrouve avec

```{mermaid}
gitGraph
    commit
    commit
    commit id: "was good"
    commit id: "not a good idea"
    commit id: "undo the wrong idea" type:HIGHLIGHT
```

dans lequel le contenu des commit `HEAD` et `HEAD~2` est identique  
mais cette approche a l'avantage de, à nouveau, laisser dans l'historique une trace de cette expérience

````{admonition} pas forcément le dernier

ici on a vu comment défaire le tout dernier commit, mais on peut tout aussi bien défaire un commit plus ancien naturellement
````
