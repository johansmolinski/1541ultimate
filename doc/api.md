# 1541 Ultimate HTTP RESTful API

Here are some ideas for the HTTP API. Losely based on Google Cloud API design guide. While this is not a strict standard, it is somewhat defacto, and generally familiar for developers.

## Some principles

* The API is stateless, meaning an operation must be completely specified in one call. For instance, you cannot make one call asking to change directory and another call to list the files in the current directory. Instead, you have to make one call to list the directory with an absolute path given. However, the 1541U is obviously not stateless. You can use the API to change configuration parameters and files.
* All endpoints are named as a noun in plural form.
* A subset of the standard HTTP verbs are used to describe the method:
  * `GET`: retrieves information, will not change anything
  * `POST`: adds supplied information
  * `PUT`: creates data based on supplied action
  * `PATCH`: changes data
  * `DELETE`: deletes data
* All endpoints support the optional query parameter `output=<text|json>`, defining the format of the HTTP body output. Default is text, useful for scripting in bash for instance. Json output is a full document on a single line.
* New endpoints and parameters may be added to the same version of the API in the future as long they do not break compatibility for existing implementations. Breaking changes must be added to a new version of the API. A released non-beta version of the API must be supported at least during the full life cycle of the major firmware version.
* For all endpoints, the default is to return `400 BAD REQUEST`. All other cases are explicitly stated in the Endpoints definitions.

The URI for calling an endpoint of API version 1 is 

`http://<IP>/v1/<endpoint>[/level1[/levelN...]][:action][?attribute1=value1[&attributeN=valueN...]]`

For instance, let's assume the IP address of the 1541U is `192.168.0.64`, to copy a file from `/Usb0/disks/my_disk.d64/my_file.prg` to `/Temp/my_folder`, we call the endpoint:

`PUT http://192.168.0.64/v1/files//Usb0/disks/my_disk.d64/my_file.prg:copy?destination=/Temp/my_folder&output=json`

Here we call the files endpoint with the `PUT` http method, specifying the absolute path to the `my_disk.d64/my_file.prg` file. Then we give the action copy. This action requires a destination query parameter containing an absolute path to the destination folder.

## Endpoints

### files

This endpoint is used for all file related actions. After the method name follows an absolute path to a file or directory. After that, an action may follow.

`GET files/<path>` (blocking): download a file.
* if path is a directory, retrieve a list of files and return `200 OK`
* if path is a single file, download the file and return `200 OK`
* if path is non-existing, return `404 NOT FOUND`

`GET files/<path>:info` (blocking): get metadata of a file.
* if path is a directory, retrieve a list of files and return `200 OK`
* if path is a single file with supported container type (like a D64 for instance), retrieve the list of content and return `200 OK`
* if path is a single file, retrieve metadata and return `200 OK`
* if path is non-existing, return `404 NOT FOUND`

`DELETE files/<path>` (blocking): deletes the given file or directory. Possible outcomes:
* if path is an existing file or directory, and is successfully deleted, return `200 OK`
* if path is not an existing file or directory, return `404 NOT FOUND`

`POST files/<path>?type=<prg|d64|d81>` (blocking): adds the supplied payload to the given path of the given type. Overwrites existing file if applicable. Possible outcomes:
* if path is a valid filename in an existing directory, and if the supplied data successfully is written to the path, return `200 OK`
* if path is not a valid filename in an existing directory, return `404 NOT FOUND`

`PUT files/<path>:createDiskImage?[type=<d64|d81>]` (blocking): creates an empty disk image at the absolute path to a file. Optionally a file type can be given (default is d64). Possible outcomes:
* if path is a valid non-existing file name and creation is successful, return `200 OK`
* if path is an existing file, return `403 FORBIDDEN`

`PUT files/<path>:mkdir?name=<name>` (blocking): create a new directory with the given `name` at the given `path`. The `path` must point to an existing directory. `name` can contain `/` separators to browse down further into the directory structure, and if needed, directories will be recursively created.
* if `path` is a valid directory and `name` is a valid directory name and creation is successful, return `200 OK`
* if `path` is non-existing, return `404 NOT FOUND`
* if `path` exists but is not a directory, return `403 FORBIDDEN`

`PUT files/<path>:copy?destination=<destination>` (blocking): copy a file or directory. The destination query argument is required. Destination can be either a directory or a file. If a directory is given, try creating the copy with the same file name as the original. If a filename is given to a non-existing file, try create the copy with the given filename. If a filename is given to an existing file, try overwrite it. Possible outcomes:
* if path is a valid readable file or directory and is successfully copied to the given destination, return `200 OK`

`PUT files/<path>:move?destination=<destination>` (blocking): move a file or directory. The destination query argument is required. Destination can be either a directory or a file. If a directory is given, move to that directory with the same file name as the original. If a filename is given to a non-existing file, rename the file to the new name and move it to the given path. If a filename is given to an existing file, overwrite it. 
* if path is a valid readable file or directory and is successfully moved to the given destination, return `200 OK`

`PUT files/<path>:loadFile[?method=<dma|real>]` (blocking): load the given file using supplied method (default dma). If method=dma, copy the file to C64 RAM and run. If method=real, use kernal to load it. This is a PUT method instead of GET, because it will modify memory. Possible outcomes:
* if file exists and is successfully, return `200 OK`
* if file does not exist, return `404 NOT FOUND`
See also `PUT machineFeatures/prg`

`PUT files/<path>:runFile[?method=<dma|real>]` (non-blocking): run the given file using supplied method (default dma). If method=dma, copy the file to C64 RAM and run. If method=real, use kernal to load it.
* if file exists and is runnable, return `200 OK` and start running
* if file does not exist, return `404 NOT FOUND`

`PUT files/<path>:runDisk[?method=<dma|real>]` (partly blocking): mount the given disk image (blocking) and run the first runnable file found (non-blocking) using the suppled method (default dma). If method=dma, copy the first file to C64 RAM and run. If method=real, use kernal to load \*. Possible outcomes:
* if file exists and is a valid disk image and is successfully mounted, return `200 OK` and start running
* if file does not exist, return `404 NOT FOUND`

`PUT files/<path>:mountDisk[?method=<dma|real>` (blocking): mount the given disk image. Possible outcomes:
* if file exists and is a valid disk image and is successfully mounted, return `200 OK`
* if file does not exist, return `404 NOT FOUND`

TODO: More endpoints

### machineFeatures

`GET machineFeatures/` (blocking): retrieve a list of available machine features: basic, chars, prg, ram, reu, reset, cart, bootDisk, reu, powerOff.
* always return `200 OK`

`GET machineFeatures/basic` (blocking): retrieve the path to the currently loaded basic rom.
* always return `200 OK`

`PUT machineFeature/basic?file=<path>` (blocking): load a basic rom.
* if file in path is successfully loaded, return `200 OK`

`GET machineFeatures/kernal` (blocking): retrieve the path to the currently loaded kernal rom.
* always return `200 OK`

`PUT machineFeature/kernal?file=<path>` (blocking): load a kernal rom.
* if file in path is successfully loaded, return `200 OK`

`GET machineFeatures/chars` (blocking): retrieve the path to the currently loaded chars rom.
* always return `200 OK`

`PUT machineFeatures/chars?file=<path>` (blocking): load a chars rom.
* if file in path is successfully loaded, return `200 OK`

`GET machineFeatures/prg[?startAddress=<>&length=<>]` (blocking): dump the file in memory. 
* if file in path is successfully loaded, return `200 OK` with a body containing the memory dump

`PUT machineFeatures/prg?file=<path>` (blocking): load a file to memory.
* if file in path is successfully loaded, return `200 OK`

`POST machineFeatures/prg?startAddress=<>` (blocking): upload supplied payload to memory at given start address.
* if data is successfully uploaded and stored in memory, return `200 OK`
* if the memory range from start address to length of payload is out of writable memory range, or covers unwritable memory, return `406 NOT ACCEPTABLE`

`PUT machineFeatures/prg:save?file=<path>[&startAddress=<>&length=<>]` (blocking): saves the prg in memory to a file
* if path is a valid filename in an existing directory, and if the supplied data successfully is written to the path, return `200 OK`

`GET machineFeatures/reset` (non-blocking): reset the C64.
* always return `200 OK` then immediately reset the C64

`GET machineFeatures/powerOff` (non-blocking): power off the U64.
* always return `200 OK` then immediately power off the U64. 

TODO:

LoadREU
SaveREU
RunCart
BootDisk
REUOn/Off/Size


### configurationParameters

TODO

