---
title: Camera
number: 8
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Learning Suite for the lab to accept the assignment.

## Objectives

- Take a picture with the camera
- Handle raw data in a buffer
- Write a `.bmp` file
- Update viewer interface

## Overview

In the past labs, much time has been spent making sure the files of the camera are easily accessible and represented on the LCD screen of your Pi Z2W kits. In this lab you will be expected to integrate a camera module to your design and take pictures. 

In the [Getting Started Lab]({% link _labs/getting-started.md %}), you should have already physically installed your camera, using the **longer** of the two ribbon cables in the correct orientation.

<!-- The following block contains content that has been copied to getting-started.md, but I'm leaving as a temporary reference.-->
<!-- <figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/camera/pi-camera.png %}" alt="Units of the course.">
  <figcaption style="text-align: center;">The Raspberry Pi Zero 2 W with the camera unit and connection cable. In this lab we will be using the larger cable and wrap it around the back of the Pi Z2W.</figcaption>
</figure> -->

<!-- 
In this lab you have received a camera kit. This kit comes with the camera module and two ribbons of different lengths. **WE WILL BE USING THE LONGER OF THESE TWO RIBBONS.** Follow the following bullet points to connect the camera to your Pi Z2W unit.

- Connect the ribbon to both the Pi Z2W and the camera module as indicated in the figure above.
- Make sure that the orientation is correct (i.e. the exposed pins of the ribbon should be on the side of the PCB, not facing up).
- Be gentle with the ribbons and their corresponding connectors. These components are fragile and a damaged ribbon could cause your system not to work!
-->

<!-- ### Doorbell Case -->

<!-- Import maps polyfill -->
<!-- Remove this when import maps will be widely supported -->
<!-- 
<script async src="https://unpkg.com/es-module-shims@1.3.6/dist/es-module-shims.js"></script>

<script type="importmap">
    {
        "imports": {
            "three": "../../assets/three.module.js"
        }
    }
</script>

<script type="module">

    import * as THREE from 'three';

    import { OrbitControls } from '../../assets/OrbitControls.js';
    import { ThreeMFLoader } from '../../assets/3MFLoader.js';

    let camera, scene, renderer, object, loader, controls;

    var container = document.getElementById('camera-lid');

    init();

    function init() {

        renderer = new THREE.WebGLRenderer( { antialias: true, alpha: true } );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( 750, 750 );
        renderer.setClearColor( 0x000000, 0 ); // the default
        container.appendChild( renderer.domElement );
        renderer.domElement.style.cursor = "grab";


        scene = new THREE.Scene();

        scene.add( new THREE.AmbientLight( 0xffffff, 0.2 ) );

        camera = new THREE.PerspectiveCamera( 30, window.innerWidth / window.innerHeight, 1, 500 );

        // Z is up for objects intended to be 3D printed.

        camera.up.set( 0, 0, 1 );
        camera.position.set( - 100, - 250, 100 );
        scene.add( camera );

        controls = new OrbitControls( camera, renderer.domElement );
        controls.addEventListener( 'change', render );
        controls.minDistance = 100;
        controls.maxDistance = 1000;
        controls.enablePan = false;
        controls.update();

        const pointLight = new THREE.PointLight( 0xffffff, 0.8 );
        camera.add( pointLight );

        const manager = new THREE.LoadingManager();

        manager.onLoad = function () {

            const aabb = new THREE.Box3().setFromObject( object );
            const center = aabb.getCenter( new THREE.Vector3() );

            object.position.x += ( object.position.x - center.x );
            object.position.y += ( object.position.y - center.y );
            object.position.z += ( object.position.z - center.z );

            controls.reset();

            scene.add( object );
            render();

        };

        loader = new ThreeMFLoader( manager );
        loadAsset( '../../assets/camera/smart-doorbell-case.3mf' );

        // window.addEventListener( 'resize', onWindowResize );

    }

    function loadAsset( asset ) {

        loader.load( asset, function ( group ) {

            if ( object ) {

                object.traverse( function ( child ) {

                    if ( child.material ) child.material.dispose();
                    if ( child.material && child.material.map ) child.material.map.dispose();
                    if ( child.geometry ) child.geometry.dispose();

                } );

                scene.remove( object );

            }

            object = group;

        } );

    }

    function onWindowResize() {

        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        renderer.setSize( window.innerWidth, window.innerHeight );

        render();

    }

    function render() {

        renderer.render( scene, camera );

    }

</script>

<script type="module">

    import * as THREE from 'three';

    import { OrbitControls } from '../../assets/OrbitControls.js';
    import { ThreeMFLoader } from '../../assets/3MFLoader.js';

    let camera, scene, renderer, object, loader, controls;

    var container = document.getElementById('camera-body');

    init();

    function init() {

        renderer = new THREE.WebGLRenderer( { antialias: true, alpha: true } );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( 500, 300 );
        renderer.setClearColor( 0x000000, 0 ); // the default
        container.appendChild( renderer.domElement );
        renderer.domElement.style.cursor = "grab";

        scene = new THREE.Scene();

        scene.add( new THREE.AmbientLight( 0xffffff, 0.2 ) );

        camera = new THREE.PerspectiveCamera( 15, window.innerWidth / window.innerHeight, 1, 500 );

        // Z is up for objects intended to be 3D printed.

        camera.up.set( 0, 0, 1 );
        camera.position.set( - 100, - 250, 100 );
        scene.add( camera );

        controls = new OrbitControls( camera, renderer.domElement );
        controls.addEventListener( 'change', render );
        controls.minDistance = 50;
        controls.maxDistance = 400;
        controls.enablePan = false;
        controls.update();

        const pointLight = new THREE.PointLight( 0xffffff, 0.8 );
        camera.add( pointLight );

        const manager = new THREE.LoadingManager();

        manager.onLoad = function () {

            const aabb = new THREE.Box3().setFromObject( object );
            const center = aabb.getCenter( new THREE.Vector3() );

            object.position.x += ( object.position.x - center.x );
            object.position.y += ( object.position.y - center.y );
            object.position.z += ( object.position.z - center.z );

            controls.reset();

            scene.add( object );
            render();

        };

        loader = new ThreeMFLoader( manager );
        loadAsset( '../../assets/cam-case-sss.3mf' );

        // window.addEventListener( 'resize', onWindowResize );

    }

    function loadAsset( asset ) {

        loader.load( asset, function ( group ) {

            if ( object ) {

                object.traverse( function ( child ) {

                    if ( child.material ) child.material.dispose();
                    if ( child.material && child.material.map ) child.material.map.dispose();
                    if ( child.geometry ) child.geometry.dispose();

                } );

                scene.remove( object );

            }

            object = group;

        } );

    }

    function onWindowResize() {

        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        renderer.setSize( window.innerWidth, window.innerHeight );

        render();

    }

    function render() {

        renderer.render( scene, camera );

    }

</script>

<span>
<figure class="image mx-auto" style="max-width: 750px">
    <div id="camera-lid"></div>
  <figcaption style="text-align: center;">Doorbell case 3D printed file. You will need to attach the camera module to the standoffs on the lid. Note that the button in this file is not included in the case you will receive in this lab.</figcaption>
</figure>

-->
<!-- 
In this lab, you were also given a 3D printed enclosure for your Pi Z2W kit. Every final system comes with its proper enclosure. Make sure you pick colors that are fun for you!

#### Case Lid

As visible in the 3D model above, there are several components that comprise this enclosure. The top of the case is the long, rectangular part with holes for the camera, LCD screen, and button respectively. You'll notice that around the camera holes are four standoffs. These standoffs correspond to the holes in the camera module mentioned in the section before. To connect properly, put the camera module through the hole of the lid and secure with the provided screws. (Make sure to remove the film over the camera module lens for the best results before mounting it to the case.)

#### LCD Screen Standoffs
These are the two rings seen in the 3D model above. These will go between the standoffs for the LCD screen and your Pi Z2W. Having these in place will ensure that your HAT is installed rigidly on your Pi Z2W and will make sure that the screen stays at the correct angle when your kit is fully enclosed in your case.

#### Case Bottom

This component is rather simple. It is the other large object in the 3D model with a rectangular hole in its ide for the ports on your Pi Z2W.S You'll notice that when you mounted your LCD and button HAT from the last module, there were two holes left over on the Pi Z2W itself that don't have any hardware connected to it. It is these holes that will slip onto the internal pegs of the bottom of the case.

#### Assembly
To put the entire case together:

1. Install the spacer rings onto the standoffs for your LCD and button HAT.
2. Mount the camera to the top lid with screws
3. Wrap the ribbon around the back of the Pi Z2W so that the camera lens is facing the same way as the LCD screen.
4. Place Pi Z2W onto the pegs of the bottom part of the case. Make sure that the usb ports are visible through the port window (the rectangular hole on the bottom).
5. Line up the lid of the case with the bottom components, ensuring that the camera ribbon is not being pinched and that the holes in the lid line up with the button and the LCD screen.
6. Snap the lid onto the bottom of the case. 
-->

### Libcamera Libraries

In order to interface with our new camera module correctly, new vendor libraries will need to be installed. Instead of installing the libraries from source as we did with the BCM2835 package, we will be using the package manager to install our files.

```bash
# Install dependencies for libcamera
sudo apt install -y libcamera-dev libjpeg-dev libtiff5-dev

# Install dependencies for libcamera-apps
sudo apt install -y cmake libboost-program-options-dev libdrm-dev libexif-dev
```

### Creating Large Buffers
The skills that you need to complete this lab are very closely related to the skills you needed for the last lab. You are expected to capture a very large buffer of information that comes from a camera and store it in a buffer (`uint8_t *`) in C. 

Normally, if we knew the size of these buffers, we would be able to create a regular array in C:
```c
uint8_t my_new_buf[256];    // Create a buffer of a known size
```

However, this becomes difficult when our buffers become very large. For example, the buffers that you dealt with in the **Image** lab had billions of values in it! This is much too large for variables that are declared on the stack. Instead, you will need to use `malloc()` in conjunction with an unbounded array:

```c
uint8_t * my_new_buf = (uint8_t *)malloc(sizeof(uint8_t) * SIZEOFYOURBUFFER);

// Whenever we are done with a malloc'd buffer in C, don't forget to call the following line:
free(my_new_buf);
```
Breaking down the `malloc` command we see that:
- `(uint8_t *)`: This casts the the results of the `malloc` command to match the type of our buffer
- `sizeof(uint8_t)`: This is the size of the type of value that will be in our buffer
- `SIZEOFYOURBUFFER`: This is a placeholder for your the actual length that you want your buffer to be.

This creates your buffer in the heap where there is much more space for larger variables like this. However, whenever we declare something in C and manage its memory, we must remember to call `free()` on the object once we are done. If this is not done, then there will be memory leaks inside of your program which could potentially grind your system to a halt.

### Writing to a File
You'll notice in your lab files for this lab, you are provided with a `camera.h` and a partially filled in `camera.c`.

In this lab you will be expected to capture image data from a camera, save it to a file, and then show it on the screen of your new smart doorbell. In order to write information to files in C, you will be expected to know one more function than you already do: `fwrite()`.

Much like reading a files as you did in the last lab, to write, you will need to open a file using `fopen()`. You may be thinking, how can I open a file when it doesn't exist yet? With `fopen()` you can name the file you want to create and what kind of mode you want to create it in by using `fopen()`. For example, to create a new file named "banana.txt", I would do the following:

```c
FILE *fp;
fp = fopen("banana.txt", "w");
```

The second command in `fopen()` is mode we want to open the file in. This allows the compiler to know what type of content will be written to the file. In our example above, we want to write ASCII text to the file (as implied with the `.txt` extension), so we use the `w` mode. Other special modes for `fopen()` can be seen in the following table below.

| Mode | Description                                                                                                                                                                                                                                                                                                                                                                                                     |
| ---- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `r`  | Open text file for reading.  The stream is positioned at the beginning of the file.                                                                                                                                                                                                                                                                                                                             |
| `r+` | Open for reading and writing.  The stream is positioned at the beginning of the file.                                                                                                                                                                                                                                                                                                                           |
| `w`  | Truncate file to zero length or create text file for writing.  The stream is positioned at the beginning of the file.                                                                                                                                                                                                                                                                                           |
| `w+` | Open for reading and writing.  The file is created if it does not exist, otherwise it is truncated.  The stream is positioned at the beginning of the file.                                                                                                                                                                                                                                                     |
| `a`  | Open for appending (writing at end of file).  The file is created if it does not exist.  The stream is positioned at the end of the file.                                                                                                                                                                                                                                                                       |
| `a+` | Open for reading and appending (writing at end of file). The file is created if it does not exist.  Output is always appended to the end of the file.  POSIX is silent on what the initial read position is when using this mode. For glibc, the initial file position for reading is at the beginning of the file, but for Android/BSD/MacOS, the initial file position for reading is at the end of the file. |

It is considered good practice to add a `b` at the end of the letter if you intend to write to a file in a binary format (i.e. `.bmp` files) to indicate your intent, however this extra `b` is not enforced on many modern systems like Linux.

After the file is opened, you can then use the `fwrite()` command to write to this opened file. Instructions on how to use `fwrite()` can be found in the corresponding link in the **Explore More!** section at the bottom of the page. Don't forget to use `fclose()` on the file pointer when you are done writing the file!

## Requirements

In this lab you should accomplish the following:
- Follow the instructions in the **Connecting the Camera** and **Libcamera Libraries** sections to prepare your Pi Z2W to take pictures.
- Copy your code from the previous lab into the cloned repository for this lab on your Pi Z2W.
- Assign the right button (or the down button in code) to do what the center button did in the previous lab. When you push the dpad to the right position, the file that is selected should be displayed.
- Reassign the center button to do the following:
    - Take a photo with the Pi Z2W's camera
    - Save the raw data received from the capture to a `.bmp` file. The files must be named `doorbell-<n>.bmp` where `<n>` is replaced by the current number of pictures taken.
    - Your code should save up to 5 `.bmp` images. If a 6th image is taken, `doorbell-1.bmp` should be overwritten, if a 7th is taken `doorbell-2.bmp` should be overwritten, etc.
    - Update your fileviewer code to include the new bitmap files that you save. (**HINT:** You may need to update your previous array of strings that contain file names to be big enough to hold the _maximum_ amount of files that could be had in this lab.)
    - Show your most recent photo for 5 seconds before you return to the file viewer.

## Submission

### Compilation
Since a large portion of this lab's grade depends on me successfully compiling your code, the following points must be adhered to to ensure consistency in the grading process. Any deviation in this will result in points off your grade:

- The code in this lab will be compiled at the root of this lab repository (i.e. `camera-<your-github-username>`). It is your responsibility to ensure that `gcc` will work from this directory.
- Your binary must output to a folder called `bin`. This folder will be marked to be ignored by `git`, meaning that I will not receive your final compiled binary to test, but rather your code which must compile successfully on my Pi Z2W.

### Gitignore
In this lab you are expected to ignore the following:

- `.vscode` folders
- the `bin` folder where your binary is generated

### Normal Stuff
- Complete all of the requirements.

- Answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.

- **MAKE SURE YOUR CODE FOLLOWS THE CODING STANDARD!** More info on how to set that up is available on the Coding Standard page. 


## Explore More!
- [`fwrite()` in C](https://www.tutorialspoint.com/c_standard_library/c_function_fwrite.htm)
- [Memory Allocation in C](https://www.geeksforgeeks.org/dynamic-memory-allocation-in-c-using-malloc-calloc-free-and-realloc/)
- [Connect Camera to Raspberry Pi](https://www.arducam.com/raspberry-pi-camera-pinout/)
