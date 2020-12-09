// // direct_uploads.js
//
// addEventListener("direct-upload:initialize", event => {
//   alert("Ho!")
//   const { target, detail } = event
//   const { id, file } = detail
//   // target.insertAdjacentHTML("beforebegin", `
//   //   <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
//   //     <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
//   //     <span class="direct-upload__filename">${file.name}</span>
//   //   </div>
//   // `)
//   const element = document.getElementById('recording_upload_progress')
//   var p = document.createElement("p")
//     var notice = document.createTextNode("uploading")
//       p.appendChild(notice)
//   element.appendChild(p)
//   var div = document.createElement("div")
//     div.id = "direct-upload-progress-${id}"
//     div.classList.add("direct-upload__progress")
//
//   element.appendChild(div)
//   element.classList.add('direct-upload direct-upload--pending')
//   // element.id = "direct-upload-${id}"
// })
//
// addEventListener("direct-upload:start", event => {
//   const { id } = event.detail
//   // const element = document.getElementById(`direct-upload-${id}`)
//   const element = document.getElementById('recording_upload_progress')
//   element.classList.remove("direct-upload--pending")
// })
//
// addEventListener("direct-upload:progress", event => {
//   const { id, progress } = event.detail
//   // const progressElement = document.getElementById(`direct-upload-progress-${id}`)
//   const progresselement = document.getElementById('recording_upload_progress')
//   progressElement.style.width = `${progress}%`
// })
//
// addEventListener("direct-upload:error", event => {
//   event.preventDefault()
//   const { id, error } = event.detail
//   // const element = document.getElementById(`direct-upload-${id}`)
//   const element = document.getElementById('recording_upload_progress')
//   element.classList.add("direct-upload--error")
//   element.setAttribute("title", error)
// })
//
// addEventListener("direct-upload:end", event => {
//   const { id } = event.detail
//   // const element = document.getElementById(`direct-upload-${id}`)
//   const element = document.getElementById('recording_upload_progress')
//   element.classList.add("direct-upload--complete")
// })