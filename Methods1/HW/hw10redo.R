
png(filename="scatter.png")
crime <- read.table('/home/nooreen/Documents/Methods/Methods1/Data/uscrime.txt', header=T)
plot(crime)
dev.off()

pdf(file="tpc.pdf")
plot(crime[,c("Prob","Time","Crime")])
dev.off()
