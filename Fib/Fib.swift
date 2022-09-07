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

//SIMD matrix
public func fib(_ n: Int) -> Double {
    let x = simd_double2(x: 1, y: 1)
    let y = simd_double2(x: 1, y: 0)
    
    var M = simd_double2x2([x, y])
    guard n > 2 else { return Double(n) }
    power(&M, n)
    return M.columns.0.y
}
func power(_ matrix: inout simd_double2x2, _ n: Int) {
    guard n > 1 else { return }
    power(&matrix, n/2)
    matrix = simd_mul(matrix, matrix)
    if n % 2 != 0 {
        let x = simd_double2(x: 1, y: 1)
        let y = simd_double2(x: 1, y: 0)
        
        let M = simd_double2x2([x, y])
        matrix = simd_mul(matrix, M)
    }
}

//normal matrix
public func fibMat(_ n: Int) -> Double {
    var M = [[1.0, 1.0], [1.0, 0.0]]
    guard n > 2 else { return Double(n) }
    powerMat(&M, n)
    return M[0][0]
}
func powerMat(_ matrix: inout [[Double]], _ n: Int) {
    guard n > 1 else { return }
    powerMat(&matrix, n/2)
    matrix = multiply(matrix, matrix)
    if n % 2 != 0 {
        let M = [[1.0, 1.0], [1.0, 0.0]]
        matrix = multiply(matrix, M)
    }
}

public func fibIt(_ n: Int) -> Double {
    var a = 1.0
    var b = 1.0
    guard n > 1 else { return a }
    
    (2...n).forEach { _ in
        (a, b) = (a + b, a)
    }
    return a
}

//recursive
public func fibRec(_ n: Double) -> Double {
    guard n > 1.0 else { return n }
    return fibRec(n-1.0) + fibRec(n-2.0)
}

func multiply(_ A: [[Double]], _ B: [[Double]]) -> [[Double]] {
    let rowCount = A.count
    let colCount = B[0].count
    var product : [[Double]] = Array(repeating: Array(repeating: 0.0, count: colCount), count: rowCount)
    for rowPos in 0..<rowCount {
        for colPos in 0..<colCount {
            for i in 0..<B.count {
                product[rowPos][colPos] += A[rowPos][i] * B[i][colPos]
            }
        }
    }
    return product
}

func fibSquare(_ n: Int) -> simd_double2x2{
    let x = simd_double2(x: 1, y: 1)
    let y = simd_double2(x: 1, y: 0)
    
    var a = simd_double2x2([x, y]) // columns
    for _ in 0..<n {
        a = simd_mul(a, a)
    }
    return a
}
