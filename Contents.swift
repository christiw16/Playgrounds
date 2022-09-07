import Foundation
import simd

//SIMD Matrix
var start = DispatchTime.now().uptimeNanoseconds
for i in 0..<1478{
    fib(i)
}
var end = DispatchTime.now().uptimeNanoseconds
print("SIMD Matrix: \((Double(end)-Double(start))/1000000.0) ms")

//Normal matrix with possible unoptimized multiplicaiton)
start = DispatchTime.now().uptimeNanoseconds
for i in 0..<1478{
    fibMat(i)
}
end = DispatchTime.now().uptimeNanoseconds
print("Normal matrix: \((Double(end)-Double(start))/1000000.0) ms")

//Iterative
start = DispatchTime.now().uptimeNanoseconds
for i in 0..<1478{
    fibIt(i)
}
end = DispatchTime.now().uptimeNanoseconds
print("Iterative: \((Double(end)-Double(start))/1000000.0) ms")

//Recursive
start = DispatchTime.now().uptimeNanoseconds
for i in 0..<40{
    fibRec(Double(i))
}
end = DispatchTime.now().uptimeNanoseconds
print("Recursive: \((Double(end)-Double(start))/1000000.0) ms")



