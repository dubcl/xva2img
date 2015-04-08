## Prelude

The .xva is actually a .tar file, that contain a xml with the configuration for XEN and folders with names like **Ref:99**, these foldes are the virtual disk of the VM.

Into of each folder has many blocks used by the virtual disk with name like **00000171** and a checksum file with name like **00000171.checksum**.

To create the raw disk you need the follow parameters:

* Name of xva file (**foo.xva**)
* Referency
* Last block of each virtual disk to convert
* Name of the new raw disk (**bar.img**)

## Obtain virtual disk folder names

Use the follow command:

```
tar tf foo.xva |awk -F "/" {'print $1'} |sort | uniq -c
```

You obtain an output like this:

```
1 ova.xml
280378 Ref:5
19522 Ref:8
```

Then you virtual disk folder are **Ref:5** and **Ref:8**

## Obtain the last virtual disk block

Use the follow command

```
tar tf foo.xva |grep Ref:5 |tail -n2
```

That show an output like:

```
Ref:99/00000174
Ref:99/00000174.checksum
```

Change the grep for you virtual disk folder **Ref** name

## Create the new raw image

Now you can use the xva2img.sh as follow:

```
./xva2img.sh foo.xva Ref:5 00000174 bar.img
```

When the command end, you have a new **bar.img** file and you can user that over KVM Hypervisor or another

## TIPS

You can use the raw image to use with VirtualBox, use the follow command to do that:

```
vboxmanage convertfromraw bar.img foo.vdi --format VDI
```

## ToDo

* Add the search commando to the script

