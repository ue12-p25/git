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

# `git` pour les hackathons

lors des hackatons on va vous demander d'exposer le travail du groupe sur github  
voici une façon de faire

- généralement la consigne vous indiquera un nom imposé pour le repo; disons par exemple `pe-hackathon`
- un des élèves crée dans son espace github le repo `jeanmineur/pe-hackathon`; pour cela, dans le formulaire de création:
  - créer le repo public
  - choisir de créer un README  
    de cette façon le repo est créé **avec déjà un commit** et peut donc être cloné  
    ```{admonition} vous avez déjà commencé ?
    :class: dropdown
    si par contre vous avez commencé et que vous avez déjà un repo local avec au moins un commit, alors

    - **au contraire** choisissez de créer **un repo vide** (pas de README, ni aucun autre contenu)
    - et suivez la recette affichée par github pour pousser ce repo sur github
    ```
- une fois le repo créé sur github (et contenant au moins un commit), il peut être cloné par tous les élèves du groupe (y compris `jeanmineur`)
- il reste alors simplement au propriétaire du groupe à donner les droits d'écriture aux autres élèves
  pour cela:
  - il les ajoute dans le repo (voir figure)
  - chacun d'entre eux accepte l'invitation reçue par mail
  - et dès lors tout le monde a le droit de `push` dans le repo (mais pensez à toujours `pull` avant de `push`)

```{image} media/github-invite-people.png
:align: center
:width: 800px
```
