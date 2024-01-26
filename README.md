# Linux Vault

Linux Vault is a security-focused project that enables users to create an encrypted loop device with layered encryption using dm-crypt/LUKS for block encryption and Google's fscrypt for file system encryption. This project aims to provide a secure and user-friendly solution for creating encrypted vaults on Linux systems.

## Table of Contents
- [Introduction](#introduction)
- [Security Model](#security-model)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Linux Vault project allows users to set up a secure vault on their Linux machine by leveraging the power of dm-crypt/LUKS and fscrypt. The project is based on bash scripts that simplify the initialization process, making it accessible to both security enthusiasts and beginners.

## Security Model

### Encryption Layers

Linux Vault employs a dual-layer encryption model:

1. **dm-crypt/LUKS (Block Encryption):** This layer encrypts the entire loop device, providing a secure foundation for data protection. It utilizes the well-established LUKS (Linux Unified Key Setup) specification.

2. **fscrypt (File System Encryption):** The file system within the loop device is encrypted using fscrypt, a file system-level encryption framework developed by Google. This adds an additional layer of security, ensuring that even individual files and directories are protected.


## Installation

To install Linux Vault on your Linux machine, follow these steps:

1. Clone the project repository:

   ```bash
   git clone https://github.com/yuvaldd9/linux-vault-guard.git
   ```

2. Navigate to the project directory:

   ```bash
   cd linux-vault
   ```

3. Run the installer script with sudo privileges:

   ```bash
   sudo ./guard_installer.sh
   ```

4. Follow the on-screen instructions to set up the encrypted loop device and configure encryption parameters.

**Note:** Ensure that you have administrative privileges and have reviewed the installation prompts before proceeding.


# USAGE

The JSON Editing Script is a Bash script designed to provide simple and convenient functions for adding, reading, and deleting key-value pairs in a JSON file using the powerful `jq` tool.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Functions](#functions)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Add Key-Value Pair**: Add a new key-value pair to the JSON file.
- **Read Key**: Retrieve the value of a specific key from the JSON file.
- **Delete Key**: Remove a key and its corresponding value from the JSON file.

## Requirements

- Bash
- jq (JSON processor) - [Installation Guide](https://stedolan.github.io/jq/download/)

## Usage

```bash
sudo vault_guard [options] <function> [arguments]
```

## Functions

- **add_key \<key\> \<value\>**: Add a key-value pair to the JSON file.
- **read_key \<key\>**: Read the value of a key from the JSON file.
- **delete_key \<key\>**: Delete a key and its corresponding value from the JSON file.

## Examples

### Add Key-Value Pair

```bash
sudo vault_guard add_key "new_key" "new_value"
```

### Read Key

```bash
sudo vault_guard read_key "existing_key"
```

### Delete Key

```bash
sudo vault_guard delete_key "key_to_delete"
```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
