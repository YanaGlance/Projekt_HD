def clean_channel(channel):
  index = channel.find('[');
  if index!=-1:
    #print(channel[:channel.find('[')-1])
    return channel[:index-1]
  return channel
  
def main():
  import csv
  with open('../Hd_ord.csv', 'w') as csvoutput:
    with open('../HD_inkrement.txt') as csvfile:
        reader = csv.reader(csvfile, delimiter=';', quotechar='"')
        writer = csv.writer(csvoutput,  lineterminator='\n', delimiter=';', quotechar='"')
        i=0
        prev_row = next(reader)
        prev_row.pop()
        writer.writerow(prev_row)
        
        prev_row = next(reader)
        prev_row.pop()
        prev_row[1] = clean_channel(prev_row[1])
        writer.writerow(prev_row)
        
        for row in reader:
            row.pop()
            for i in range(0, len(row)):
              if i==1:
                row[i] = clean_channel(row[i])
              if row[i]=='' or row[i] == None:
                #print(row[i])
                row[i] = prev_row[i]
              else:
                prev_row[i] = row[i]
            writer.writerow(row)
            
if __name__ == '__main__':
  main()
          

