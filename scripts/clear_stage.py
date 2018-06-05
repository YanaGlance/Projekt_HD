import csv
with open('../Hd_ord.csv', 'w') as csvoutput:
  with open('../HD_full.txt') as csvfile:
      reader = csv.reader(csvfile, delimiter=';', quotechar='"')
      writer = csv.writer(csvoutput,  lineterminator='\n', delimiter=';', quotechar='"')
      i=0
      prev_row = next(reader)
      prev_row.pop()
      writer.writerow(prev_row)
      
      prev_row = next(reader)
      prev_row.pop()
      writer.writerow(prev_row)
      for row in reader:
          row.pop()
          for i in range(0, len(row)):
            if row[i]=='' or row[i] == None:
              #print(row[i])
              row[i] = prev_row[i]
            else:
              prev_row[i] = row[i]
          writer.writerow(row)