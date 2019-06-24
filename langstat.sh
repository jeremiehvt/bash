#!/bin/bash

#vérification de la présence d'au moins un paramètre
#et init vatiables
if [ -z $1 ]; then

	echo "ajouter au moins un paramètre pour que le script fonctionne"	
else
	docMo="$1_modified.txt"	
	archive="$1.zip"
	doc="$1.txt"

fi

#vérification de la présence du deuxième paramètre facultatif
#et init variable
if [ "$2" != "" ]; then
	newDoc="$2.csv"	
fi

#récupération des fichiers du repertoires courant 
files=$(ls)

#init du tableau des lettres
carachters=('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z')

trie ()
{

	#suppression des fichiers parasites
	#ou déjà existant
	for file in $files
	do
		if [ "$file" == "$doc" ] || [ "$file" == "$archive" ] ||  [ "$file" == "$newDoc" ] ||  [ "$file" == "$docMo" ]; then
			rm $file
		fi
	done
	
	touch $docMo
	
	#téléchargement et decompression de l'archive au nom souhaité en param 1
	wget -O $archive http://www.siteduzero.com/uploads/fr/ftp/mateo21/cpp/dico.zip
 	unzip -j $archive

	#lecture du tableau des lettres
	#et classement et trie
	for i in "${carachters[@]}"
	do
		#boucle if si deuxième paramètre
		#classer dans un fichier csv 

		if [ "$newDoc" != "" ]; then
			if [ $i == "a" -o $i == "A" ]; then
				touch "$newDoc"
			fi 
			echo "$(grep $i -oi $doc | wc -l);-;$i" >> $docMo
			if [ $i == "z" -o $i == "Z" ]; then
				echo "les données ont été triés par ordre croissant dans le fichier : $newDoc"
				sort -nr $docMo >> $newDoc
				rm $docMo $doc $archive
			fi
		else
			echo "$(grep $i -oi $doc | wc -l) - $i" >> $docMo
			if [ $i == "z" -o $i == "Z" ]; then
				echo "les données ont été triés par ordre croissant"
				sort -nr $docMo
				rm $docMo $doc $archive
			fi
		fi
	done
	
}

trie 
