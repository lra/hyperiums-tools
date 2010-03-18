#!/usr/bin/env ruby
#
# taglist.rb 0.1
# http://www.glop.org/
# (c) 2003 Laurent Raufaste <analogue@glop.org>
#
# Changelog :
# 0.1 : - premiere version

# emplacement des fichiers
ALLIANCE_FILE = "alliancelist.txt"

# Rien a modifier sous cette ligne
# --------------------------------

# ca ne sert a rien de continuer si ALLIANCE_FILE n'existe pas
if not File.exists?(ALLIANCE_FILE) then
	print "Impossible de trouver #{ALLIANCE_FILE}\n"
	exit(1)
end

# on mets toutes les lignes du fichier dans le tableau lines
lines = IO.readlines(ALLIANCE_FILE)

# on enleve les 1eres lignes commentees du fichier
while lines.first[0].chr == "#"
	lines.shift
end

# on cherche la tag demandé toutes les 3 lignes
0.step(lines.length, 3) { |i|
	if lines[i]
		print lines[i].split[0] + "\n"
	end
}
