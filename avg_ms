#!/usr/bin/env ruby
#
# avg_ms.rb 0.1
# http://www.glop.org/
# (c) 2003 Laurent Raufaste <analogue@glop.org>
#
# Changelog :
# 0.1 : - premiere version

# emplacement des fichiers
PLANET_FILE = "planetlist.txt"

# Rien a modifier sous cette ligne
# --------------------------------

PROD_TYPES = ["Agro", "Minero", "Techno"]

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

somme_ms = [0, 0, 0]
count_ms = [0, 0, 0]

# on cherche les planetes du tag demande
lines.each { |l|
	if l =~ / \[#{ARGV[0]}\] /i
		ms_type = l.split[12][0].chr.to_i
		ms = l.split[12][2..-1].to_i
		somme_ms[ms_type] = ms + somme_ms[ms_type].to_i
		count_ms[ms_type] = count_ms[ms_type].to_i + 1
		ms_type = l.split[13][0].chr.to_i
		somme_ms[ms_type] = somme_ms[ms_type].to_i + l.split[13][2..-1].to_i
		count_ms[ms_type] = count_ms[ms_type].to_i + 1
	end
}

if (count_ms[0] == 0) && (count_ms[1] == 0) && (count_ms[2] == 0) then
	print "Aucune planete avec le tag specifie\n"
	exit(1)
end

print PROD_TYPES[0] + ": " + (somme_ms[0] / count_ms[0]).to_s + ", "
print PROD_TYPES[1] + ": " + (somme_ms[1] / count_ms[1]).to_s + ", "
print PROD_TYPES[2] + ": " + (somme_ms[2] / count_ms[2]).to_s + "\n"
