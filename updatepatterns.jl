using JSON
using DelimitedFiles

rawnotes = JSON.parsefile(ARGS[1])["_notes"]
notes = Array{Tuple, 1}()

function getnotedata(note::Dict)::Tuple
  x = note["_lineIndex"]
  y = note["_lineLayer"]
  t = note["_time"]
  d = note["_cutDirection"]
  c = note["_type"]
  directions = [0 1 3 2 5 4 7 6 8 9 10]
  n = c == 0 ? x + y * 4 + d * 12 + 1 : (3 - x) + y * 4 + directions[d + 1] * 12 + 1
  return (n, c)
end

for note in rawnotes
  notedata = getnotedata(note)
  if notedata[2] == 0 || notedata[2] == 1
    push!(notes, notedata)
  end
end

samecolor = readdlm("samecolor.csv", Int32)
diffcolor = readdlm("diffcolor.csv", Int32)
samecolor2 = readdlm("samecolor2.csv", Int32)
diffcolor2 = readdlm("diffcolor2.csv", Int32)

cnotes = [[0, 0], [0, 0]]
for note in notes
  c = note[2]
  if 1 <= note[1] <= 96
    if 1 <= cnotes[c + 1][2] <= 96 && samecolor[cnotes[c + 1][2], note[1]] != 0
      samecolor[cnotes[c + 1][2], note[1]] += 1
    end
    if 1 <= cnotes[2 - c][2] <= 96 && diffcolor[cnotes[2 - c][2], note[1]] != 0
      diffcolor[cnotes[2 - c][2], note[1]] += 1
    end
    if 1 <= cnotes[c + 1][1] <= 96 && samecolor2[cnotes[c + 1][1], note[1]] != 0
      samecolor2[cnotes[c + 1][1], note[1]] += 1
    end
    if 1 <= cnotes[2 - c][1] <= 96 && diffcolor2[cnotes[2 - c][1], note[1]] != 0
      diffcolor2[cnotes[2 - c][1], note[1]] += 1
    end
  end
  cnotes[c + 1][1] = cnotes[c + 1][2]
  cnotes[c + 1][2] = note[1]
end

writedlm("samecolor.csv", samecolor)
writedlm("diffcolor.csv", diffcolor)
writedlm("samecolor2.csv", samecolor2)
writedlm("diffcolor2.csv", diffcolor2)
