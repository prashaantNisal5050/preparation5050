// mukesh : https://www.youtube.com/watch?v=GtiRvrrwak0&list=PLB97yPrFwo5gn9mAzWNHmjxAspUSeF_nk&index=9


/** 
 * flattern the array
*/
// numbers = [1,2,[3,4,[5,6]],7];
// function FlattenArray(arr){
//     const result = arr.reduce((acc, val) => {
//         return acc.concat(Array.isArray(val) ? FlattenArray(val):val);
//         console.log(val)
//     },[])
//     return result;
// }

// console.log(FlattenArray(numbers))


/**
 * implement method chaining 
 * obj.add(1).add(3).sum(1,2,3).sum(1,2,3)
 */

// const obj = {
//   value: 0,
//   add(num){
//     this.value += num;
//     return this;
//   },
//   sum(...args){
//     // debugger
//     const result = this.value + args.reduce((acc, val) => {
//       return acc + val
//     },0)
//     this.value = result
//     return this

//   }   
// }

// console.log(obj.add(1).add(3).sum(1,2,3).sum(1,2,3).value)
 
// let avc = 12;
// avc = 22;
// console.log(avc)



// const obj1 = {
//   name: "prashant",
//   age: 22
// }


// // for(key in obj1){
// // console.log(obj1[key])
// // }

// Object.values(obj1).forEach(value => {
// console.log(value)
// })

function debounce(fn, delay) {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => {
      fn.apply(this, args);
    }, delay);
  };
}

// Actual function to run
function handleSearch(event) {
  console.log('Searching for:', event.target.value);
// simulate API call here
}

// Wrap with debounce
const debouncedSearch = debounce(handleSearch, 1000);

// Attach to input event
document.getElementById('searchInput').addEventListener('input', debouncedSearch);
