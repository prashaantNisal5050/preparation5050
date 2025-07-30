/* 10. Write a sum method which will work properly when invoked using either syntax below.
https://www.geeksforgeeks.org/javascript/what-is-currying-function-in-javascript/
*/

// function sum(x) {
//   if (arguments.length == 2) {
//     return arguments[0] + arguments[1];
//   } else {
//     return function(y) { return x + y; };
//   }
// }


/*
Immediately Invoked Function Expression (IIFE)
11.Consider the following code snippet:

| Feature                 | With `var` + IIFE   | With `let`                   |
| ----------------------- | ------------------- | ---------------------------- |
| Scope of `i`            | Function            | Block                        |
| Value captured per loop | Via closure in IIFE | Automatically by block scope |
| Code complexity         | Higher              | Lower                        |

notes : 
1.If you're using ES6 or later, you can replace var with let and skip the IIFE:
2. What does the IIFE do? It captures the current value of i in a new function scope: It captures the current value of i in a new function scope, 
   so it can access the current value of i 
*/

// (function(parameter) {
//   // function body using 'parameter'
//   console.log("hey " +parameter)
// })(99);

// for (var i = 0; i < 5; i++) {
//   var btn = document.createElement('button');
//   btn.appendChild(document.createTextNode('Button ' + i));
//   // (function(i){
//     btn.addEventListener('click', function(){ console.log(i); });
//   // })(i)
//   document.body.appendChild(btn);
// }



// var d = {};
// [ 'zebra', 'horse' ].forEach(function(k) {
// 	d[k] = undefined;
// });

// console.log(d)


/*
13. What will the code below output to the console and why?
*/ 

// var arr1 = "john".split(''); // lengh is 4 
// var arr2 = arr1.reverse(); // lengh is 4 , arr2 is pointing to arr1. means any changes in arr2 will reflect in arr1
// var arr3 = "jones".split(''); 
// arr2.push(arr3); //arr2 changed

// console.log("array 1: length=" + arr1.length + " last=" + arr1.slice(-1)); //notice arr1: length is 5 (not 4)
// console.log("array 2: length=" + arr2.length + " last=" + arr2.slice(-1));


/*
14.What will the code below output to the console and why ?
*/
// console.log(1 +  "2" + "2"); // (number + string = string)
// console.log(1 +  +"2" + "2"); //unary plus converts string to number 1 + 2 = 3+"2" = 32
// console.log(1 +  -"1" + "2"); //1 + (-1) → 0
// console.log(+"1" +  "1" + "2");
// console.log( "A" - "B" + "2"); // (non-numeric strings can't be subtracted)
// console.log( "A" - "B" + 2); // NaN becomes string when added to string

/*
15.The following recursive code will cause a stack overflow if the array list is too large. How can you fix this and still retain the recursive pattern?
*/

// var list = readHugeList();
// var nextListItem = function() {
//     var item = list.pop();

//     if (item) {
//         // process the list item...
//         nextListItem();
//     }
// };


/*
16. What is a “closure” in JavaScript? Provide an example.
*/

// var globalVar = "xyz";

// (function outerFunc(outerArg) {
//     var outerVar = 'a';
    
//     (function innerFunc(innerArg) {
//     var innerVar = 'b';
    
//     console.log(
//         "outerArg = " + outerArg + "\n" +
//         "innerArg = " + innerArg + "\n" +
//         "outerVar = " + outerVar + "\n" +
//         "innerVar = " + innerVar + "\n" +
//         "globalVar = " + globalVar);
    
//     })(456);
// })(123);

// outerArg = 123
// innerArg = 456
// outerVar = a
// innerVar = b
// globalVar = xyz

/*

17.What would the following lines of code output to the console?
*/

// console.log("0 || 1 = "+(0 || 1));
// console.log("1 || 2 = "+(1 || 2));
// console.log("0 && 1 = "+(0 && 1));
// console.log("1 && 2 = "+(1 && 2));


/*
19.What is the output out of the following code? Explain your answer.
*/

/*
var a={},
    b={key:'b'},
    c={key:'c'};
    console.log(a);
    a[b]=123;
    a[c]=456;

{
"[object Object]": 456
}

*/

/* use map : Map keeps keys by reference, not by string coercion. So b and c are treated as two separate keys.
new Map([
    [
        {
            "key": "b"
        },
        123
    ],
    [
        {
            "key": "c"
        },
        456
    ]
])
*/


// const a = new Map();
// const b = { key: 'b' };
// const c = { key: 'c' };

// a.set(b, 123);
// a.set(c, 456);


/*
22.What will the following code output to the console and why:

*/
// (function(x) {
//     return (function(y) {
//         console.log(x);
//     })(2)
// })(1);


// var hero = {
//     _name: 'John Doe',
//     getSecretIdentity: function () {
//         return this._name;
//     }
// };

// var stoleSecretIdentity = hero.getSecretIdentity;

// console.log(stoleSecretIdentity());         // ❓ What will this print?
// console.log(hero.getSecretIdentity());  

/*
24.Testing your this knowledge in JavaScript: What is the output of the following code?
*/
// var length = 10;
// function fn() {
// 	console.log(this);
// }

// var obj = {
//   length: 5,
//   method: function(fn) {
//     // fn();
//     arguments[0]();
//   }
// };

// obj.method(fn, 1);

/*
25.Testing your this knowledge in JavaScript: What is the output of the following code?
Concept Tested: Scoping + Hoisting + Catch Block Shadowing
*/

// (function () {
//     try {
//         throw new Error();
//     } catch (x) {
//         var x = 1, y = 2;
//         console.log(x);
//     }
//     console.log(x);
//     console.log(y);
// })();

/*
 above code converted to below after hoisting
(function () {
    var x, y; // outer and hoisted
    try {
        throw new Error();
    } catch (x) { // inner x
        x = 1; // inner x, not the outer one
        y = 2; // there is only one y, which is in the outer scope
        console.log(x); // inner
    }
    console.log(x);
    console.log(y);
})();

*/


/* hoisting
26.What will be the output of this code?
*/
// var x = 21;
// var girl = function () {
//     var x;            // ← hoisted declaration (not the assignment)
//     console.log(x);   // x is declared but undefined
//     x = 20;           // assignment happens after console.log
// };
// girl();


/* let vs var
27.What will this code print?
*/

// (let i = 0; i < 5; i++) {
//   setTimeout(function() { console.log(i); }, i * 1000 );
// }

/*
28.What do the following lines output, and why?
*/
// console.log(1 < 2 < 3); // 1<2 => true < 3 means 1<3 hence true 
// console.log(3 > 2 > 1);// 3>2 => true > 1 means 1>1 hence false

/*
30. sparse array in JavaScript

| Loop Type    | Skips Empty? | Can Print All Indices?  |
| ------------ | ------------ | ----------------------- |
| `.map()`     | ✅ Yes        | ❌ (unless filled first) |
| `.forEach()` | ✅ Yes        | ❌                       |
| `for` loop   | ❌ No         | ✅                       |
| `for...in`   | ❌ No         | ✅ (but keys as strings) |
| `for...of`   | ✅ Yes        | ❌                       |


*/
// var a = [1, 2, 3];
// a[10] = 99;
// console.log(a);

// a.forEach((val, index) => {
//   console.log(index, val);
// });

// a.map((val, index) => {
//   console.log(index, val);
// });

// a = a.fill(undefined, 0, a.length); // now all slots exist

// a.map((val, index) => {
//   console.log(index, val);
// });

// for (let i = 0; i < a.length; i++) {
//   console.log(i, a[i]);
// }

/*
31.What is the value of typeof undefined == typeof NULL?

| Feature                   | `undefined`                                                                | `null`                                            |
| ------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------- |
| **Type**                  | `undefined` (primitive)                                                    | `object` (this is a known bug in JS)              |
| **Meaning**               | A variable has been declared but **not assigned** a value yet              | A variable is **explicitly set** to have no value |
| **Set by**                | JavaScript (by default)                                                    | Developer (intentionally)                         |
| **Common Use Case**       | Uninitialized variables, missing function parameters, or object properties | Explicitly clearing a variable or object field    |
| **Equality (==)**         | `null == undefined` → `true`                                               | `null == undefined` → `true`                      |
| **Strict Equality (===)** | `undefined === null` → `false`                                             | `null === null` → `true`                          |

*/

/*
32.
What would following code return?
console.log(typeof typeof 1)

string
typeof 1 will return "number" and typeof "number" will return string.
;*/


/*
What is NaN? What is its type? How can you reliably test if a value is equal to NaN?
*/
