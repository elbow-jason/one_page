import { channel } from "./socket"

export class Handler {
  constructor(channel){
    this.channel = channel
    this.id      = null
  }

  onKeyDown(e){
    console.log("e", e.key)
    this.channel.push("keydown", {key: e.key})
  }

  onClick(e){
    console.log("click", e.target.id)
    this.channel.push("click", {id: e.target.id})
  }

  onMove({clientX, clientY}){
    console.log("move", "x",clientX, "y", clientY)
    this.channel.push("mousemove", {clientX, clientY})
  }
}

function listenFor(name, cb) {
  let theListened = (e) => {
    return cb(e)
  }
  window.addEventListener(name, theListened)
  return () => {
    window.removeEventListener(name, theListened)
  }
}

export class Keys {
  constructor(handler){
    this.removeKeys = listenFor("keydown", handler.onKeyDown.bind(handler))
  }
}

export class Mouse {
  constructor(handler){
    this.removeClick = listenFor("click", handler.onClick.bind(handler))
    this.removeMove  = listenFor("mousemove", handler.onMove.bind(handler))
  }
}
