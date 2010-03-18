#!/usr/bin/env ruby
#
# alliance.rb 0.2.3
# http://www.glop.org/
# (c) 2003 Laurent Raufaste <analogue@glop.org>
#
# Changelog :
# 0.1 : - premiere version
# 0.2 : - resolution d'un probleme pour les alliances sans president
#       - n'affiche pas le president s'il n'existe pas
# 0.2.1 : - bug a la con corrigé
# 0.2.2 : - bug sur le formatage des nb negatifs
# 0.2.3 : - cosmétique
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# emplacement des fichiers
ALLIANCE_FILE = "alliancelist.txt"
ALLIANCE_FILE_YESTERDAY = "alliancelist.yesterday.txt"

# Rien a modifier sous cette ligne
# --------------------------------

# classe de l'alliance concernee
class Alliance
	attr_accessor	:tag,
			:name,
			:description,
			:president,
			:x,
			:y,
			:planets,
			:planets_yesterday,
			:influence,
			:influence_yesterday

	def format(nb, separator = ',',decimal = '\.')
		#return nb.to_s.reverse.scan(/.{1,3}/).join(",").reverse
		return nb.to_s.gsub(/(\d)(?=\d{3}+$)/, '\1,')
	end

	def info
		print "Alliance #{tag} - "
		if description.length > 0
			print "#{description} - "
		end
		if president.length > 0
			print "President : #{president} - "
		end
		print "Nombre de planètes : #{format(planets)} "
		if planets_yesterday
			planets_diff = planets.to_i - planets_yesterday.to_i
			if planets_diff >= 0
				planets_diff = "+" + format(planets_diff)
			else
				planets_diff = format(planets_diff)
			end
			print "(#{planets_diff}) "
		end
		print "- "
		print "Influence : #{format(influence)}"
		if influence_yesterday
			influence_diff = influence.to_i - influence_yesterday.to_i
			if influence_diff >= 0
				influence_diff = "+" + format(influence_diff)
			else
				influence_diff = format(influence_diff)
			end
			print " (#{influence_diff})"
		end
		print "\n"
	end
end

alliance = Alliance.new

# on accepte un seul argument: le tag de l'alliance
if ARGV.length != 1
	print "Usage: " + $0 + " \"tag de l'alliance\"\n"
	exit(1)
end

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
	# on check le tag
	if lines[i] =~ /^#{ARGV[0]} /i
		alliance.tag = lines[i].split[0]
		alliance.name = lines[i].split(' ', 2)[1]
		alliance.description = lines[i+1].strip
		matches = /(\w*) (-??\d+) (-??\d+) (\d+) (\d+)/.match(lines[i+2])
		alliance.president = matches[1]
		alliance.x = matches[2]
		alliance.y = matches[3]
		alliance.planets = matches[4]
		alliance.influence = matches[5]
	end
}

# on recommence avec ALLIANCE_FILE_YESTERDAY pour comparer les donnees de la veille
if File.exists?(ALLIANCE_FILE_YESTERDAY)
	lines = IO.readlines(ALLIANCE_FILE_YESTERDAY)

	# on enleve les 1eres lignes commentees du fichier
	while lines.first[0].chr == "#"
		lines.shift
	end

	# on cherche la tag demandé toutes les 3 lignes
	0.step(lines.length, 3) { |i|
		# on check le tag
		if lines[i] =~ /^#{ARGV[0]} /i
			matches = /(\w*) (-??\d+) (-??\d+) (\d+) (\d+)/.match(lines[i+2])
			alliance.planets_yesterday = matches[4]
			alliance.influence_yesterday = matches[5]
		end
	}
end

# si une alliance a été trouvée, on l'affiche
if alliance.tag then
	alliance.info
else
	print "Aucune alliance portant le tag #{ARGV[0]} trouvée\n"
end
