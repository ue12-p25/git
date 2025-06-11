# -*- coding: utf-8 -*-
[ -d my-first-project-2 ] && {
    echo
    echo "le dossier my-first-project-2 existe; tapez :"
    echo
    echo "rm -rf my-first-project-2"
    echo
    echo "pour l'effacer avant de relancer"
    echo
    exit 1
}


# on a créé un répertoire et on s'y est déplacé
mkdir my-first-project-2
cd my-first-project-2

# on a créé un fichier readme.md
echo "ce répertoire est réservé à l'implémentation d'une fonction factorielle" > readme.md

# on a créé un fichier licence.txt
echo "Licence machin truc chose, Prénom Nom" > licence.txt

# on a initialisé notre repository git
git init


##### 1-er commit
# on a ajouté les fichiers readme.md et licence.txt dans l'index
git add readme.md licence.txt

# on a créé notre premier commit
git commit -m"licence+readme"


##### 2-ème commit
# on a modifié le fichier readme.md
echo "la licence d'utilisation est dans le fichier licence.txt" >> readme.md
# on l'a ajouté dans l'index
git add readme.md

# on a modifié notre fichier licence.txt
echo "la licence sera spécifiée ultérieurement" >> licence.txt

# on a créé un fichier fact.py
echo "def fact (n):" > fact.py
echo "    pass" >> fact.py

# on a rajouté le fichier de licence.txt dans l'index
git add licence.txt

# on a créé un second commit (sans mettre fact.py)
git commit -m"informations sur la licence"


##### 3-ème commit
# on a ajouté fact.py dans l'index
git add fact.py

# on a fait un troisième commit
git commit -m"première implémentation de factorielle dans le fichier fact.py"


##### 4-ème commit
cat > fact.py << EOF
def fact (n):
    if n == 1:
        return 1
    else:
        return n*fact(n-1)
    pass
EOF

git add fact.py
git commit -m"une implémentation plus juste de la fonction factorielle"


##### revenir en arrière
git branch devel HEAD~
git switch devel


##### commit sur la branche
cat > licence.txt << EOF
License Creative Commons CC-BY-NC-ND 4.0
https://creativecommons.org/licenses/by-nc-nd/4.0/
EOF

git add licence.txt
git commit -m"licence CC"


##### fusion
git merge main -m "ma première fusion"


##### on en est là
git log --all --oneline --graph
