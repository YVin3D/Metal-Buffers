# Metal-Buffers
A framework that encapsulates memory management for GPU buffers on Metal


## SharedBuffer<T>

Allocates a buffer with `.storageModeShared` that is accesible to both the CPU and GPU. Handles memory management and everything automatically. There is an optional argument that of type array `[T]` that will initialize the buffer with the contents of this array

## DeviceBuffer<T>

Allocates a buffer with `.storageModePrivate` that is accessible to **only the GPU**. Handles memory management and everything automatically. There is an optional argument that of type array `[T]` that will initialize the buffer with the contents of this array.

**Note:** Using the `contents` argument requires the commandQueue to be also passed in. The initializer initializes a `SharedBuffer<T>` and using a blitCommandEncoder to copy the contents from the shared buffer to the `DeviceBuffer<T>`. This is the recommended behavior as per Apple's guidelines, but **it is** an expensive operation. <u>Only use this sparingly.</u>
