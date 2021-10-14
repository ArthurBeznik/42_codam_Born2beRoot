## Encrypt partitions using LVM
### Configuration
Here is how we can create encrypted partitions using LVM, in the Debian installer.

#### Step 1
Once reaching the partition disks menu. Select **Manual**
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 13 05 PM" src="https://user-images.githubusercontent.com/43698378/137306914-a8ebcd0f-f92e-4e84-abe3-a745b7c55cb1.png">
</p>

#### Step 2
Choose the disk to partition, there should only be one, as we are on a VM.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 14 14 PM" src="https://user-images.githubusercontent.com/43698378/137307043-80ea09a6-0d54-4705-a6c1-f3507c65bd58.png">
</p>

Select **Yes** to create a new empty partition table.

Read this about partitioning from debian.org:
> When using LVM or encrypted LVM, the installer will create most partitions inside one big partition; the advantage of this method is that partitions inside this big partition can be resized relatively easily later. **In the case of encrypted LVM the big partition will not be readable without knowing a special key phrase, thus providing extra security of your (personal) data.**

> When using encrypted LVM, the installer will also automatically **erase the disk by writing random data to it**. This further improves security (as it makes it impossible to tell which parts of the disk are in use and also makes sure that any traces of previous installations are erased), but may take some time depending on the size of your disk.

#### Step 3
We now have to create a partition dedicated to `/boot`. Go on the **FREE SPACE**.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 21 59 PM" src="https://user-images.githubusercontent.com/43698378/137308142-6098806e-ae78-4cab-9dca-9a68895ccf16.png">
</p>

Create a **new partition** of **487M** (subject's example), of **Primary** type and it has to be located at the **beginning** of your device.

You should end up on a **Partition settings** screen and you have to change **Mount point** to /boot, **label** as boot and turn **on** the **Bootable flag**. As follows:
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 25 50 PM" src="https://user-images.githubusercontent.com/43698378/137308867-d0655e02-c239-4ebd-a49d-e3fb8221f681.png">
</p>

Click on **Done setting up the partition** and you should have this:
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 28 58 PM" src="https://user-images.githubusercontent.com/43698378/137309134-6c0b5b71-7ebe-4c1f-b831-9007a5af2c8e.png">
</p>

**GG!** Now to set up ***encrypted*** volumes.

#### Step 4
Click on **Configure encrypetd volumes**.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 31 10 PM" src="https://user-images.githubusercontent.com/43698378/137309464-537af2f1-d26e-409a-a5f2-364a890f129a.png">
</p>

Select **Yes** to write the changes and configure encrypted volumes.

#### Step 5
Now, **Create encrypted volumes**
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 38 50 PM" src="https://user-images.githubusercontent.com/43698378/137310453-8690a57a-cecd-48d8-898c-ae4917807fb3.png">
</p>

Select the **FREE SPACE** device.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 39 26 PM" src="https://user-images.githubusercontent.com/43698378/137310596-5d66ac2c-cbc4-467a-b0a2-bad2a982d899.png">
</p>

You should now have this screen:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 41 05 PM" src="https://user-images.githubusercontent.com/43698378/137310788-d9002cfa-cb71-4529-8b7b-89057db7c43a.png">
</p>

Nothing has to be modified here, select **Done setting up the partition**.

#### Step 6
Again, you will be asked to write the current partitioning scheme. Select **Yes** and continue.

You are now back on the encrypted volumes menu. ***I'm not sure if we need to encrypt another one or not*** but select **Finish**.

#### Step 7
Select **Yes** to encrypt. This process might take some time.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 46 15 PM" src="https://user-images.githubusercontent.com/43698378/137311449-02d3b87a-65d3-4d08-a518-44e455da79f9.png">
</p>

#### Step 8
We now have to give a **passphrase** to encrypt:
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-12 at 12 03 03 PM" src="https://user-images.githubusercontent.com/43698378/136935811-8b1948ac-74a0-48f7-a147-243d9dbfefef.png">
</p>

#### Step 9
Back on this menu, you should have something like this:
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 50 42 PM" src="https://user-images.githubusercontent.com/43698378/137312045-9982e56a-a724-4720-90a4-31abf03bb6f4.png">
</p>

Select **Configure the Logical Volume Manager**.

You will be asked to write the current partitioning scheme before you continue. Agree and continue.

#### Step 10
Now we are at the LVM configuration menu. Select **Create Volume group** and continue. At the next screen you will be prompted to name your new volume group. Subject's example shows `wil--vg`, I will therefore call mine `abeznik--vg`.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 1 52 38 PM" src="https://user-images.githubusercontent.com/43698378/137312392-113c5a50-c48b-4460-9457-1cae9ae539af.png">
</p>

Then select the device for the new volume group, which is the encryted one.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 56 13 PM" src="https://user-images.githubusercontent.com/43698378/137312709-d9564740-9e61-4720-8739-1238058bc50a.png">
</p>

### Useful links
- [Manually partition Debian](https://unix.stackexchange.com/questions/577379/how-can-i-install-debian-with-full-disk-encryption-and-a-custom-sized-swapfile)
- [Debian - partitioning](https://www.debian.org/releases/buster//amd64/ch06s03.en.html#di-partition)
