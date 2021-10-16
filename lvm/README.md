## Encrypt partitions using LVM
### Configuration
Here is how we can create encrypted partitions using LVM, in the Debian graphical installer.

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
We now have to create a partition dedicated to `/boot`, otherwise **we won't be able to boot**, obviously. Go on the **FREE SPACE**.
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
Now we are at the LVM configuration menu. Select **Create Volume group** and continue. At the next screen you will be prompted to name your new volume group. Subject's example shows `wil--vg`, I will therefore call mine `abeznik-vg`, one `-` prints two of them, apparently.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-15 at 12 45 16 PM" src="https://user-images.githubusercontent.com/43698378/137475511-e43d210a-9555-4dea-b4d0-c241153e3132.png">
</p>

Then select the device for the new volume group, which is the encryted one.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 1 56 13 PM" src="https://user-images.githubusercontent.com/43698378/137312709-d9564740-9e61-4720-8739-1238058bc50a.png">
</p>

#### Step 11
Now that we have configured a physical volume group, we need to create **logical volumes**.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 3 14 30 PM" src="https://user-images.githubusercontent.com/43698378/137324574-f5464940-1a10-4cdd-8101-587090a48e4c.png">
</p>

When creating a logical volume, you need to select a volume group, give the logical volume a name, and size. This is going to be a **root** partition so I have named it and sized it according to the subject.
<p align=center>
<img width="524" alt="Screen Shot 2021-10-15 at 12 46 01 PM" src="https://user-images.githubusercontent.com/43698378/137476021-8dd7eb27-55db-4f56-8fa9-94ea2395353b.png">
<img width="524" alt="Screen Shot 2021-10-14 at 3 17 59 PM" src="https://user-images.githubusercontent.com/43698378/137325204-d702b58f-928f-472f-878e-1c2041665e72.png">
<img width="524" alt="Screen Shot 2021-10-14 at 3 19 13 PM" src="https://user-images.githubusercontent.com/43698378/137325314-41b888c6-3005-4350-b973-0feb55733cc5.png">
</p>

You will have to do this step 3 times in order to have `root` (2.8G), `swap_1` (976M) and `home` (3.8G). When that is done, by selecting **Display configuration details**, you should have as follows:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 3 22 49 PM" src="https://user-images.githubusercontent.com/43698378/137325963-d76ef1e3-b1f1-4fc6-a6cf-e3f968489683.png">
</p>

And select **Finish**.

#### Step 12
Now that we have configured LVM we need to actually configure the partitions on the drive. Back on the main partition disks menu, it should like something like this:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 3 24 33 PM" src="https://user-images.githubusercontent.com/43698378/137326318-96a6b1d5-8a13-4a29-a8e6-92aac90c63b9.png">
</p>

Double click or select a partition (In this case `home`) and configure it appropriately.
<p align=center>
  <img width="524" alt="Screen Shot 2021-10-14 at 3 25 43 PM" src="https://user-images.githubusercontent.com/43698378/137326569-555507b8-26d6-4635-9418-260c13821137.png">
  <img width="524" alt="Screen Shot 2021-10-14 at 3 26 34 PM" src="https://user-images.githubusercontent.com/43698378/137326706-0e72042c-294d-41f4-b950-880d18b3458b.png">
  <img width="524" alt="Screen Shot 2021-10-14 at 3 27 13 PM" src="https://user-images.githubusercontent.com/43698378/137326806-ece2b6ee-8670-4a28-98f0-0533ddffee6a.png">
  <img width="524" alt="Screen Shot 2021-10-14 at 3 27 47 PM" src="https://user-images.githubusercontent.com/43698378/137326889-375ea0ef-fc4d-4fac-83bc-3a7bdaa22001.png">
  <img width="524" alt="Screen Shot 2021-10-14 at 3 28 10 PM" src="https://user-images.githubusercontent.com/43698378/137326954-7ad795b3-2436-4352-a7f5-191f4cd010d4.png">
  <img width="524" alt="Screen Shot 2021-10-14 at 3 29 18 PM" src="https://user-images.githubusercontent.com/43698378/137327178-38545052-d186-455a-8d87-fb31bb7c6327.png">
</p>

As the screenshots show, I'm configuring this partition to be an **ext4 filesystem, mounted at `/home`, and labeled as home**, do the same thing for `root`. For `swap` instead of being an ext4 filesystem, select **swap area**.

#### Step 13
Now you are back to the main menu, it should look like this:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-14 at 3 33 51 PM" src="https://user-images.githubusercontent.com/43698378/137327932-0245f563-d352-4d39-8995-646aca3d0af2.png">
</p>

Select **Finish partitioning and write changes to disk** and ***voila***!

### Useful links
- [Manually partition Debian](https://unix.stackexchange.com/questions/577379/how-can-i-install-debian-with-full-disk-encryption-and-a-custom-sized-swapfile)
- [Debian - partitioning](https://www.debian.org/releases/buster//amd64/ch06s03.en.html#di-partition)
