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

# UE12 - la gestion de versions avec `git`

+++

[![Published](https://img.shields.io/badge/Published-Website-green)](https://git.info-mines.paris)
[![MyST Build Status](https://img.shields.io/github/actions/workflow/status/ue12-p25/git/myst-to-pages.yml?branch=main&label=MyST%20Build%20Status)](https://github.com/ue12-p25/git/actions/workflows/myst-to-pages.yml)
[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/ue12-p25/git)
[![Git Cheat Sheet](https://img.shields.io/badge/Git-Cheat%20Sheet-orange?logo=git)](https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf)

[![License: CC BY-NC-ND](https://img.shields.io/badge/License-CC%20BY--NC--ND-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/) *Valérie Roy & Thierry Parmentelat*

## un survol en slides

Pour les néophytes, [voici un slideshow pour
illustrer rapidement **le besoin**, et **les cas d'usage** les plus simples](media/kn2-introduction-git.pdf)

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
  * <https://datafoundation.org/news/blogs/335/335-Version-Control-for-Law-Tracking-Changes-in-the-US-Congress>
* la mise à disposition **d'open-data**:
  * <https://github.com/collections/open-data>

En réalité il potentiellement utile pour pratiquement **tout ce qui est numérique**  
même si clairement **il s'applique le mieux** à des contenus **de nature textuelle**
