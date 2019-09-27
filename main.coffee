# MAIN ############################################################################################

canvas = document.querySelector "canvas"
gl = canvas.getContext "webgl"

resize = ()->
  w = canvas.clientWidth * window.devicePixelRatio |0
  h = canvas.clientHeight * window.devicePixelRatio |0
  canvas.width = w if canvas.width isnt w
  canvas.height = h if canvas.height isnt h

degToRad = (d)-> d * Math.PI / 180

random = (range)-> Math.random() * range |0

setGeometry = ()->
  verts = new Float32Array [
          # left column front
          0,   0,  0,
          0, 150,  0,
          30,   0,  0,
          0, 150,  0,
          30, 150,  0,
          30,   0,  0,

          # top rung front
          30,   0,  0,
          30,  30,  0,
          100,   0,  0,
          30,  30,  0,
          100,  30,  0,
          100,   0,  0,

          # middle rung front
          30,  60,  0,
          30,  90,  0,
          67,  60,  0,
          30,  90,  0,
          67,  90,  0,
          67,  60,  0,

          # left column back
            0,   0,  30,
           30,   0,  30,
            0, 150,  30,
            0, 150,  30,
           30,   0,  30,
           30, 150,  30,

          # top rung back
           30,   0,  30,
          100,   0,  30,
           30,  30,  30,
           30,  30,  30,
          100,   0,  30,
          100,  30,  30,

          # middle rung back
           30,  60,  30,
           67,  60,  30,
           30,  90,  30,
           30,  90,  30,
           67,  60,  30,
           67,  90,  30,

          # top
            0,   0,   0,
          100,   0,   0,
          100,   0,  30,
            0,   0,   0,
          100,   0,  30,
            0,   0,  30,

          # top rung right
          100,   0,   0,
          100,  30,   0,
          100,  30,  30,
          100,   0,   0,
          100,  30,  30,
          100,   0,  30,

          # under top rung
          30,   30,   0,
          30,   30,  30,
          100,  30,  30,
          30,   30,   0,
          100,  30,  30,
          100,  30,   0,

          # between top rung and middle
          30,   30,   0,
          30,   60,  30,
          30,   30,  30,
          30,   30,   0,
          30,   60,   0,
          30,   60,  30,

          # top of middle rung
          30,   60,   0,
          67,   60,  30,
          30,   60,  30,
          30,   60,   0,
          67,   60,   0,
          67,   60,  30,

          # right of middle rung
          67,   60,   0,
          67,   90,  30,
          67,   60,  30,
          67,   60,   0,
          67,   90,   0,
          67,   90,  30,

          # bottom of middle rung.
          30,   90,   0,
          30,   90,  30,
          67,   90,  30,
          30,   90,   0,
          67,   90,  30,
          67,   90,   0,

          # right of bottom
          30,   90,   0,
          30,  150,  30,
          30,   90,  30,
          30,   90,   0,
          30,  150,   0,
          30,  150,  30,

          # bottom
          0,   150,   0,
          0,   150,  30,
          30,  150,  30,
          0,   150,   0,
          30,  150,  30,
          30,  150,   0,

          # left side
          0,   0,   0,
          0,   0,  30,
          0, 150,  30,
          0,   0,   0,
          0, 150,  30,
          0, 150,   0]
  gl.bufferData gl.ARRAY_BUFFER, verts, gl.STATIC_DRAW


setColors = ()->
  colors =  new Uint8Array [
          # left column front
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,

          # top rung front
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,

          # middle rung front
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,
        200,  70, 120,

          # left column back
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,

          # top rung back
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,

          # middle rung back
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,
        80, 70, 200,

          # top
        70, 200, 210,
        70, 200, 210,
        70, 200, 210,
        70, 200, 210,
        70, 200, 210,
        70, 200, 210,

          # top rung right
        200, 200, 70,
        200, 200, 70,
        200, 200, 70,
        200, 200, 70,
        200, 200, 70,
        200, 200, 70,

          # under top rung
        210, 100, 70,
        210, 100, 70,
        210, 100, 70,
        210, 100, 70,
        210, 100, 70,
        210, 100, 70,

          # between top rung and middle
        210, 160, 70,
        210, 160, 70,
        210, 160, 70,
        210, 160, 70,
        210, 160, 70,
        210, 160, 70,

          # top of middle rung
        70, 180, 210,
        70, 180, 210,
        70, 180, 210,
        70, 180, 210,
        70, 180, 210,
        70, 180, 210,

          # right of middle rung
        100, 70, 210,
        100, 70, 210,
        100, 70, 210,
        100, 70, 210,
        100, 70, 210,
        100, 70, 210,

          # bottom of middle rung.
        76, 210, 100,
        76, 210, 100,
        76, 210, 100,
        76, 210, 100,
        76, 210, 100,
        76, 210, 100,

          # right of bottom
        140, 210, 80,
        140, 210, 80,
        140, 210, 80,
        140, 210, 80,
        140, 210, 80,
        140, 210, 80,

          # bottom
        90, 130, 110,
        90, 130, 110,
        90, 130, 110,
        90, 130, 110,
        90, 130, 110,
        90, 130, 110,

          # left side
        160, 160, 220,
        160, 160, 220,
        160, 160, 220,
        160, 160, 220,
        160, 160, 220,
        160, 160, 220
  ]
  gl.bufferData gl.ARRAY_BUFFER, colors, gl.STATIC_DRAW

translation = [45, 60, 0]
rotation = [degToRad(40), degToRad(25), degToRad(325)]
scale = [1,1,1]

positionBuffer = null
colorBuffer = null
positionLocation = null
matrixLocation = null
colorLocation = null

main = (program)->
  positionLocation = gl.getAttribLocation program, "a_position"
  colorLocation = gl.getAttribLocation program, "a_color"
  matrixLocation = gl.getUniformLocation program, "u_matrix"

  positionBuffer = gl.createBuffer()
  gl.bindBuffer gl.ARRAY_BUFFER, positionBuffer
  setGeometry()

  colorBuffer = gl.createBuffer()
  gl.bindBuffer gl.ARRAY_BUFFER, colorBuffer
  setColors()

  drawScene program

drawScene = (program)->
  resize()
  gl.viewport 0, 0, canvas.width, canvas.height
  gl.clearColor 0, 0, 0, 0
  gl.clear gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT
  gl.enable gl.CULL_FACE
  gl.enable gl.DEPTH_TEST

  # RENDER SETUP
  gl.useProgram program

  gl.enableVertexAttribArray positionLocation
  gl.bindBuffer gl.ARRAY_BUFFER, positionBuffer
  size = 3          # 2 components per iteration
  type = gl.FLOAT   # the data is 32bit floats
  normalize = false # don't normalize the data
  stride = 0        # 0 = move forward size * sizeof(type) each iteration to get the next position
  offset = 0        # start at the beginning of the buffer
  gl.vertexAttribPointer positionLocation, size, type, normalize, stride, offset

  gl.enableVertexAttribArray colorLocation
  gl.bindBuffer gl.ARRAY_BUFFER, colorBuffer
  size = 3          # 2 components per iteration
  type = gl.UNSIGNED_BYTE   # the data is 32bit floats
  normalize = true # don't normalize the data
  stride = 0        # 0 = move forward size * sizeof(type) each iteration to get the next position
  offset = 0        # start at the beginning of the buffer
  gl.vertexAttribPointer colorLocation, size, type, normalize, stride, offset

  left = 0
  right = canvas.clientWidth
  bottom = canvas.clientHeight
  top = 0
  near = 400
  far = -400
  matrix = m4.orthographic left, right, bottom, top, near, far
  # matrix = m4.projection(canvas.clientWidth, canvas.clientHeight, 400)
  matrix = m4.translate(matrix, translation[0], translation[1], translation[2])
  matrix = m4.xRotate(matrix, rotation[0])
  matrix = m4.yRotate(matrix, rotation[1])
  matrix = m4.zRotate(matrix, rotation[2])
  matrix = m4.scale(matrix, scale[0], scale[1], scale[2])

  gl.uniformMatrix4fv(matrixLocation, false, matrix)

  # RENDER
  gl.drawArrays gl.TRIANGLES, 0, 16 * 6




# UTILS ###########################################################################################

m4 =
  perspective: (fieldOfViewInRadians, aspect, near, far)->
    f = Math.tan Math.PI * 0.5 - 0.5 * fieldOfViewInRadians
    rangeInv = 1.0 / (near - far)
    [
      f / aspect, 0, 0, 0,
      0, f, 0, 0,
      0, 0, (near + far) * rangeInv, -1,
      0, 0, near * far * rangeInv * 2, 0
    ]
  orthographic: (left, right, bottom, top, near, far)->
    [
      2 / (right - left), 0, 0, 0,
      0, 2 / (top - bottom), 0, 0,
      0, 0, 2 / (near - far), 0,

      (left + right) / (left - right),
      (bottom + top) / (bottom - top),
      (near + far) / (near - far),
      1
    ]
  translation: (tx, ty, tz)->
    [
      1,  0,  0,  0,
      0,  1,  0,  0,
      0,  0,  1,  0,
      tx, ty, tz, 1,
    ]

  xRotation: (angleInRadians)->
    c = Math.cos(angleInRadians)
    s = Math.sin(angleInRadians)
    [
      1, 0, 0, 0,
      0, c, s, 0,
      0, -s, c, 0,
      0, 0, 0, 1,
    ]

  yRotation: (angleInRadians)->
    c = Math.cos(angleInRadians)
    s = Math.sin(angleInRadians)
    [
      c, 0, -s, 0,
      0, 1, 0, 0,
      s, 0, c, 0,
      0, 0, 0, 1,
    ]

  zRotation: (angleInRadians)->
    c = Math.cos(angleInRadians)
    s = Math.sin(angleInRadians)
    [
       c, s, 0, 0,
      -s, c, 0, 0,
       0, 0, 1, 0,
       0, 0, 0, 1,
    ]

  scaling: (sx, sy, sz)->
    [
      sx, 0,  0,  0,
      0, sy,  0,  0,
      0,  0, sz,  0,
      0,  0,  0,  1,
    ]
  translate: (m, tx, ty, tz)-> m4.multiply(m, m4.translation(tx, ty, tz))
  xRotate: (m, angleInRadians)-> m4.multiply(m, m4.xRotation(angleInRadians))
  yRotate: (m, angleInRadians)-> m4.multiply(m, m4.yRotation(angleInRadians))
  zRotate: (m, angleInRadians)-> m4.multiply(m, m4.zRotation(angleInRadians))
  scale: (m, sx, sy, sz)-> m4.multiply(m, m4.scaling(sx, sy, sz))
  multiply: (a, b)->
    b00 = b[0 * 4 + 0]
    b01 = b[0 * 4 + 1]
    b02 = b[0 * 4 + 2]
    b03 = b[0 * 4 + 3]
    b10 = b[1 * 4 + 0]
    b11 = b[1 * 4 + 1]
    b12 = b[1 * 4 + 2]
    b13 = b[1 * 4 + 3]
    b20 = b[2 * 4 + 0]
    b21 = b[2 * 4 + 1]
    b22 = b[2 * 4 + 2]
    b23 = b[2 * 4 + 3]
    b30 = b[3 * 4 + 0]
    b31 = b[3 * 4 + 1]
    b32 = b[3 * 4 + 2]
    b33 = b[3 * 4 + 3]
    a00 = a[0 * 4 + 0]
    a01 = a[0 * 4 + 1]
    a02 = a[0 * 4 + 2]
    a03 = a[0 * 4 + 3]
    a10 = a[1 * 4 + 0]
    a11 = a[1 * 4 + 1]
    a12 = a[1 * 4 + 2]
    a13 = a[1 * 4 + 3]
    a20 = a[2 * 4 + 0]
    a21 = a[2 * 4 + 1]
    a22 = a[2 * 4 + 2]
    a23 = a[2 * 4 + 3]
    a30 = a[3 * 4 + 0]
    a31 = a[3 * 4 + 1]
    a32 = a[3 * 4 + 2]
    a33 = a[3 * 4 + 3]
    dst = []
    dst[ 0] = b00 * a00 + b01 * a10 + b02 * a20 + b03 * a30;
    dst[ 1] = b00 * a01 + b01 * a11 + b02 * a21 + b03 * a31;
    dst[ 2] = b00 * a02 + b01 * a12 + b02 * a22 + b03 * a32;
    dst[ 3] = b00 * a03 + b01 * a13 + b02 * a23 + b03 * a33;
    dst[ 4] = b10 * a00 + b11 * a10 + b12 * a20 + b13 * a30;
    dst[ 5] = b10 * a01 + b11 * a11 + b12 * a21 + b13 * a31;
    dst[ 6] = b10 * a02 + b11 * a12 + b12 * a22 + b13 * a32;
    dst[ 7] = b10 * a03 + b11 * a13 + b12 * a23 + b13 * a33;
    dst[ 8] = b20 * a00 + b21 * a10 + b22 * a20 + b23 * a30;
    dst[ 9] = b20 * a01 + b21 * a11 + b22 * a21 + b23 * a31;
    dst[10] = b20 * a02 + b21 * a12 + b22 * a22 + b23 * a32;
    dst[11] = b20 * a03 + b21 * a13 + b22 * a23 + b23 * a33;
    dst[12] = b30 * a00 + b31 * a10 + b32 * a20 + b33 * a30;
    dst[13] = b30 * a01 + b31 * a11 + b32 * a21 + b33 * a31;
    dst[14] = b30 * a02 + b31 * a12 + b32 * a22 + b33 * a32;
    dst[15] = b30 * a03 + b31 * a13 + b32 * a23 + b33 * a33;
    dst
  projection: (width, height, depth)->
    # Note: This matrix flips the Y axis so 0 is at the top.
    [
       2 / width, 0, 0, 0,
       0, -2 / height, 0, 0,
       0, 0, 2 / depth, 0,
      -1, 1, 0, 1
    ]


ajaxSuccess = (xhr, opts)-> (e)->
  if xhr.status is 200
    opts.success xhr.response, e, xhr
  else
    console.log "AJAX Failure"

AJAX = (opts)->
  xhr = new XMLHttpRequest()
  xhr.open "GET", opts.url
  xhr.addEventListener "load", ajaxSuccess xhr, opts
  xhr.send()

createShader = (source, type)->
  shader = gl.createShader type
  gl.shaderSource shader, source
  gl.compileShader shader
  throw "failed compile: #{gl.getShaderInfoLog shader}" unless gl.getShaderParameter shader, gl.COMPILE_STATUS
  shader

createProgram = (vertexSource, fragmentSource)->
  program = gl.createProgram()
  gl.attachShader program, createShader vertexSource, gl.VERTEX_SHADER
  gl.attachShader program, createShader fragmentSource, gl.FRAGMENT_SHADER
  gl.linkProgram program
  throw "failed link: #{gl.getProgramInfoLog program}" unless gl.getProgramParameter program, gl.LINK_STATUS
  program


# INIT ############################################################################################

AJAX url: "main.fshader", success: (fragmentSource)->
  AJAX url: "main.vshader", success: (vertexSource)->
    main createProgram vertexSource, fragmentSource
