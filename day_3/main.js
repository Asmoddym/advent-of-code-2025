const fs = require("fs")

function readFileContent(filePath) {
  return fs.readFileSync(filePath, 'utf8')
}

function part(lines, tupleSize) {
  sum = 0

  lines.forEach(line => {
    let num = 0

    const chars = line.split("")
    let maxId = 0
    let rangeBegin = 0

    for (let t = tupleSize; t > 0; t--) {
      let rangeEnd = chars.length - t
      maxId = 0

      // Basically you always need to find the max as long as you still have enough remaining string to end the tupleSize.
      chars.slice(rangeBegin, rangeEnd + 1).forEach((char, index) => {
        if (parseInt(char) > parseInt(chars[rangeBegin + maxId])) {
          maxId = index
        }
      })

      num += parseInt(chars[rangeBegin + maxId]) * (t - 1 == 0 ? 1 : Math.pow(10, t - 1))

      rangeBegin += maxId + 1
    }

    sum += num
  })

  console.log(sum)
}

const content = readFileContent(process.argv[2]).split('\n').slice(0, -1)

// Part 1
part(content, 2)

// Part 2
part(content, 12)
