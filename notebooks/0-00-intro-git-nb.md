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
  title: introduction
---

License CC BY-NC-ND, Thierry Parmentelat & Valérie Roy

```{code-cell}
%%python
from IPython.display import HTML
HTML(filename="_static/style.html")
```

# UE12 - la gestion de versions avec `git`

+++

## un survol en slides

Pour les néophytes, [voici un slideshow](media/kn2-introduction-git.pdf) pour
illustrer rapidement **le besoin**, et **les cas d'usage** les plus simples;
[accessible aussi
ici](https://github.com/ue12-p24/git/raw/main/notebooks/media/kn2-introduction-git.pdf)

````{admonition} pour lire le PDF
:class: tip

la présentation contient des animations, assurez-vous de bien la visionner en
mode slideshow  
durée : grand maximum 10', il ne s'agit **pas de tout comprendre** mais juste de
brosser le contexte
````

+++

## pourquoi git ?

Après plusieurs décennies de tâtonnements, et des strates d'outils dédiés à la gestion de versions (sccs, rcs, cvs, subversion, mercurial, …), le constat que l'on peut faire en 2020 est que le vainqueur est git, et sans doute pour un bon moment encore; jugez par vous même :

* la plateforme github annonce 40 millions de comptes de développeurs
* pratiquement tous les outils dont on a parlé jusqu'ici (Python, numpy, pandas, matplotlib, git lui-même bien sûr, mais aussi linux, Jupyter, etc…) ont leurs sources ouvertes et disponibles sous git (à l'exception notable de vs-code, mais il existe une variante open-source vs-codium)

Ça signifie que, même si l'apprentissage de git peut apparaitre aride aux débutants, c'est aujourd'hui **un standard de fait** dans toute l'industrie du logiciel, et au delà…

+++

## git pour du code, mais pas que

Signalons en effet que git est utilisé **aussi** pour notamment :

* le processus d'**élaboration des lois**:
  * <https://datacoalition.org/blog/12844184>
* la mise à disposition **d'open-data**:
  * <https://github.com/collections/open-data>

En réalité il potentiellement utile pour pratiquement **tout ce qui est numérique**  
même si clairement **il s'applique le mieux** à des contenus **de nature textuelle**

+++

## d'autres ressources pour ce cours

* en version HTML statique :  
  <https://ue12-p24-git.readthedocs.io/>

* les sources de ce cours :
  <https://github.com/ue12-p24/git>
  
* également utile, une *cheat sheet* éditée par github :  
  <https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf>
