#!/usr/bin/env ruby
#
# avg_civ.rb 0.1
# http://www.glop.org/
# (c) 2003 Laurent Raufaste <analogue@glop.org>
#
# Changelog :
# 0.1 : - premiere version

# emplacement des fichiers
PLANET_FILE = "planetlist.txt"

# Rien a modifier sous cette ligne
# --------------------------------

# on accepte un seul argument: le tag de l'alliance
if ARGV.length != 1
	print "Usage: " + $0 + " \"tag de l'alliance\"\n"
	exit(1)
end

# ca ne sert a rien de continuer si ALLIANCE_FILE n'existe pas
if not File.exists?(PLANET_FILE) then
	print "Impossible de trouver #{PLANET_FILE}\n"
	exit(1)
end

# on mets toutes les lignes du fichier dans le tableau lines
lines = IO.readlines(PLANET_FILE)

# on enleve les 1eres lignes commentees du fichier
while lines.first[0].chr == "#"
	lines.shift
end

somme_civ = 0
planet_count = 0

# on cherche les planetes du tag demande
lines.each { |l|
	if l =~ / \[#{ARGV[0]}\] /i
		somme_civ += l.split[10].to_i
		planet_count += 1
	end
}

if planet_count == 0 then
	print "Aucune planete avec le tag specifie\n"
	exit(1)
end

moy_civ = somme_civ / planet_count

print moy_civ.to_s + "\n"
