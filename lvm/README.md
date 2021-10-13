## Encrypt partitions using LVM
### Configuration
Here is how we can create encrypted partitions using LVM, in the Debian installer.

#### Step 1
Once reaching the partition disks menu. Select **Guided - use entire disk and set up encrypted LVM**
<p align=center>
<img width="524" alt="Screen Shot 2021-10-12 at 11 47 46 AM" src="https://user-images.githubusercontent.com/43698378/136933537-0c5f7d2f-41ca-4fea-b8ed-fa9b175eb7ae.png">
</p>

#### Step 2
Choose the disk to partition, there should only be one, as we are giving the whole disk
<p align=center>
<img width="524" alt="Screen Shot 2021-10-12 at 11 53 18 AM" src="https://user-images.githubusercontent.com/43698378/136934478-a5cfd2a3-4842-4f10-ae85-4b042914cd14.png">
</p>

Read this about partitioning from debian.org:
> When using LVM or encrypted LVM, the installer will create most partitions inside one big partition; the advantage of this method is that partitions inside this big partition can be resized relatively easily later. **In the case of encrypted LVM the big partition will not be readable without knowing a special key phrase, thus providing extra security of your (personal) data.**

> When using encrypted LVM, the installer will also automatically **erase the disk by writing random data to it**. This further improves security (as it makes it impossible to tell which parts of the disk are in use and also makes sure that any traces of previous installations are erased), but may take some time depending on the size of your disk.

#### Step 3
We now have to decide on the partitioning scheme, choose **All files in one partition**
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-12 at 11 58 50 AM" src="https://user-images.githubusercontent.com/43698378/136935153-b7a5e67c-608b-4d4f-aa27-cca31b13ada3.png">
</p>

#### Step 4
Accept the modifications to be made and the installer should format and partition the disk.

#### Step 5
We now have to give a passphrase to encrypt:
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-12 at 12 03 03 PM" src="https://user-images.githubusercontent.com/43698378/136935811-8b1948ac-74a0-48f7-a147-243d9dbfefef.png">
</p>

#### Step 6
We will now give the amount of volume group to use for guied partitioning. The example in the subject shows a 7.5 GB encrypted partition, guess we'll be oing the same:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-12 at 12 05 00 PM" src="https://user-images.githubusercontent.com/43698378/136936240-0a74792a-dceb-44f8-9728-926b19bcfd86.png">
</p>

#### Step 7
Accept the modifications and writes and it should be good.

### Useful links
- [Manually partition Debian](https://unix.stackexchange.com/questions/577379/how-can-i-install-debian-with-full-disk-encryption-and-a-custom-sized-swapfile)
- [Debian - partitioning](https://www.debian.org/releases/buster//amd64/ch06s03.en.html#di-partition)
