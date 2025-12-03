const fs = require("fs")

function readFileContent(filePath) {
  return fs.readFileSync(filePath, 'utf8')
}

function part(lines, tupleSize) {
  sum = 0

  lines.forEach(line => {
    const chars = line.split("")
    let remaining = chars
    let maxId = 0

    chars.slice(0, chars.length - tupleSize + 1).forEach((char, index) => {
      if (parseInt(char) > parseInt(chars[maxId])) {
        maxId = index
      }
    })

    let num = parseInt(chars[maxId]) * Math.pow(10, tupleSize - 1)

    for (let t = tupleSize - 1; t > 0; t--) {
      remaining = remaining.slice(maxId + 1, remaining.length)
      maxId = 0

      // Basically you always need to find the max as long as you still have enough remaining string to end the tupleSize.
      remaining.slice(0, remaining.length - t + 1).forEach((char, index) => {if (parseInt(char) > parseInt(remaining[maxId])) maxId = index})
      num += parseInt(remaining[maxId]) * (t - 1 == 0 ? 1 : Math.pow(10, t - 1))
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
