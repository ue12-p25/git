# -*- coding: utf-8 -*-
[ -d my-first-conflict-2 ] && {
    echo
    echo "le dossier my-first-conflict-2 existe; tapez :"
    echo
    echo "rm -rf my-first-conflict-2"
    echo
    echo "pour l'effacer avant de relancer"
    echo
    exit 1
}

mkdir my-first-conflict-2
cd my-first-conflict-2
git init


cat > form.txt << EOF
prof #1 Nom  :
prof #1 Note :
---
prof #2 Nom  :
prof #2 Note :
---
total        :
EOF

git add form.txt
git commit -m "le formulaire vierge"


# le premier prof remplit sa partie
cat > form.txt << EOF
prof #1 Nom  : McGonagall
prof #1 Note : 12
---
prof #2 Nom  :
prof #2 Note :
---
total        : 12
EOF

git add form.txt
git commit -m "notes mcgonagall"


# on rembobine
git switch -c dumbledore HEAD~

# le deuxième prof
cat > form.txt << EOF
prof #1 Nom  :
prof #1 Note :
---
prof #2 Nom  : Dumbledore
prof #2 Note : 15
---
total        : 15
EOF

git add form.txt
git commit -m"notes dumbledore"

###
git log --all --oneline --graph


git switch main
git merge dumbledore


### arrêt d'urgence
git merge --abort


### mais si on est un peu plus aventureux
# on recommence (à cause du abort)
git merge dumbledore

echo ""
echo "il vous reste à résoudre le conflit à la main et à finaliser la fusion"
echo "pour ça commencez par aller dans le repo"
echo ""
echo "cd $(pwd)"
echo ""
