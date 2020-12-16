is.integer(7)
round(7) == 7
is.integer(as.integer(7))
0.33 == 3 * 0.11
0.45 == 3 * 0.15
round(0.45, 2) == round(3 * 0.15, 2)
x <- c(7,8,10,45)
y <- c(-7,-8,-10,-45)
x + y
x + c(-7,-8)
x <- c(1,2,3,4)
x.a <- array(x,dim=c(2,2))
x.a
dim(x.a)
is.vector(x.a)
is.array(x.a)
x <- c(1,2,3,4)
x.a <- array(x, dim = c(2,2))
x.a[1,1]
x.a[,1]
which(x.a <= 2)
rowSums(x.a)
x.b <- array(c(-1,-2,-3,-4), dim = c(2,2))
x.c <- x.a + x.b
x.c
m <- matrix(c(40,1,60,3), nrow=2)
m
is.array(m)
is.matrix(m)
f <- matrix(c(40,1,60,3),nrow=2)
f
six.fives <- matrix(rep(5,6), ncol=3)
six.fives
f %*% six.fives
f
o <- c(10,20)
o
f %*% o
rownames(f) <- c("трудодни","сталь")
colnames(f) <- c("автомобили","грузовики")
f
output <- c(20,10)
names(output) <- c("грузовики","автомобили")
available <- c(1600,70)
names(available) <- c("трудодни","сталь")
f %*% output[colnames(f)]
apply(f,1,mean)
f
apply(f,2,mean)
my.lst <- list("exponential",7,FALSE)
my.lst
names(my.lst) <- c("family","mean","is.symmetric")
my.lst
my.lst$family
a.matrix <- matrix(c(35,8,10,4),nrow=2)
colnames(a.matrix) <- c("v1","v2")
a.matrix
a.matrix$v1
a.data.frame <- data.frame(a.matrix, logicals=c(TRUE,FALSE))
a.data.frame
a.data.frame$v1
a.data.frame[,"v1"]
a.data.frame[1,]
colMeans(a.data.frame)
rbind(a.data.frame,list(v1=-3,v2=-5,logicals = TRUE))
rbind(a.data.frame,c(3,4,6))
