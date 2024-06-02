# YANG Tools

YANG (Yet Another Next Generation) is a data modeling language used in network management and device configuration. YANG formally describes data models for network elements. It provides a way to define the data structure, hierarchy, and constraints for configuration and operational state data. YANG models are written in a human-readable format, making it easier for network engineers to understand and work with. YANG is designed to be platform-independent, allowing it to be used with various networking technologies and protocols.

YANG models are used in conjunction with protocols like NETCONF, RESTCONF, and gNMI to configure and manage network devices. They provide a standardized way to represent device configuration and operational state, improving interoperability and automation.

Some of the concepts associated with YANG:

- Modules: YANG models are organized into modules, which are self-contained units of YANG code. Each module defines a set of related data elements and operations.
- Data Types: YANG supports various data types such as integers, strings, booleans, enumerations, and custom-defined types.
- Hierarchical Structure: YANG models define a hierarchical structure for organizing data elements, similar to a tree structure with nodes and leaf nodes.
- Constraints: YANG allows the definition of constraints on data elements, such as minimum and maximum values, patterns, and ranges.

YANG Syntax:

- YANG modules begin with the *module* or *submodule* keyword followed by the module name.
- Data elements are defined using statements such as *container*, *leaf*, *list*, *choice*, and *typedef*.
- Relationships between data elements are defined using *child* and *parent* statements.
- Constraints and other metadata are specified using various YANG statements and annotations.


The following is an example of a YANG Module. The module defines a container named *example-container* containing a leaf node named *example-leaf*

```yang
module example-module {
 namespace "urn:example-module";
 prefix exm;

 container example-container {
   leaf example-leaf {
     type string;
     description "Example leaf node";
   }
 }
}
```
.

The are several YANG Tools and Utilities that help with using YANG:

- YANG compilers and validators help validate YANG modules for correctness and adherence to the YANG syntax.
- YANG development tools such as Pyang, YANG Explorer, and YANG Development Kit (YDK) assist in creating, editing, and working with YANG models.

This repository define a Docker container that includes several YANG tools that can assist in learning and developing in YANG.

## Installed Tools

Two commonly used tools are included:

- yanglint: A feature-rich tool for validation and conversion of YANG schemas and modeled data. You can use it to validate YANG modules, generate tree representations, and validate JSON/XML instance data.
- pyang: A YANG validator, transformator, and code generator written in Python. It can validate YANG modules, transform them into other formats, and generate code from the modules.

## Usage

1. Clone the repository

   ```
   $ git clone https://github.com/martimy/YANG-Tools
   ```

2. Pull the Docker image:

   ```
   $ docker pull martimy/yangtools:latest
   ```

3. Start the Docker container using one of the following methods:

   ```
   $ docker run --rm -it -v $(pwd)/.:/app/ martimy/yangtools:latest
   ```

   The `-v` option mounts the current directory from the host machine to the /app/ directory inside the container. This allows the container to access files in the current directory of the host. You can change the directory to the location of your yang models.

   or, use the included script:

   ```
   $ ./yangtools <commands and options>
   ```

   I you use this option, remmeber that your yang models will be located in the /app directory.

   or,

   ```
   $ ./yangtools
   auser@1d07e45b4921:/app$
   ```

## Examples

Here are some example of using the `yanglint` and `pyang`. Please refer to the tools' documentation for more details.

**Validate YANG Modules**:

Use `yanglint` to validate your YANG module. For example:

```
$ yanglint pc-components.yang
```

The tool will display nothing if the YANG module is correct and adheres to the YANG specification.

```
$ pyang --ietf -p . pc-components.yang
```

**Generate Tree Representation of YANG mdodule**:

To create a tree representation of your YANG module, use:

```
$ yanglint -f tree pc-components.yang
module: pc-components
  +--rw pc
     +--rw cpu
     |  +--rw brand?   string
     |  +--rw model?   string
     |  +--rw cores?   uint16
     |  +--rw speed?   decimal64
     +--rw memory
     |  +--rw size?    uint64
     |  +--rw type?    string
     |  +--rw speed?   uint32
     +--rw storage
     |  +--rw type?       enumeration
     |  +--rw capacity?   uint64
     +--rw peripherals
        +--rw device* [name]
           +--rw name    string
           +--rw type?   enumeration
```

The `pyang` can produce the same output.

```
$ pyang -f tree -p <yang-search-path> pc-components.yang
```


**Convert Instance Data**:

Validate JSON or XML instance data using `yanglint`:

```
$ yanglint pc-components.yang data.json
```

You can also convert instance data from one format to another.

```
$ yanglint -f json pc-components.yang data.xml
```

**Generate Skeleton Instance Data**:

Generate skeleton instance data (XML or JSON) for your YANG module:

```
$ pyang -p . -f sample-xml-skeleton --sample-xml-skeleton-defaults pc-components.yang -o module.xml
```

```
$ $ pyang -p . -f jsonxsl pc-components.yang -o module.xsl
$ xsltproc -o module.json module.xsl module.xml
```

```
$ cat module.json
{
  "pc-components:pc": {
    "cpu": {
      "brand": "",
      "model": "",
      "cores": "",
      "speed": ""
    },
    "memory": {
      "size": "",
      "type": "",
      "speed": ""
    },
    "storage": {
      "type": "",
      "capacity": ""
    },
    "peripherals": {
      "device": [
        {
          "name": "",
          "type": ""
        }
      ]
    }
  }
}
```

You can covert the above JSON file to YAML (assuming no errors):

```
$ jy-converter module.json
$ cat module.yaml
pc-components:pc:
  cpu:
    brand: ''
    cores: ''
    model: ''
    speed: ''
  memory:
    size: ''
    speed: ''
    type: ''
  peripherals:
    device:
    - name: ''
      type: ''
  storage:
    capacity: ''
    type: ''
```

**Indent a YANG file**:

```
$ pyang -p . \
--keep-comments -f yang --yang-canonical \
pc-components.yang -o output.yang
```


## Resources

- [Understanding YANG - Nokia Network Developer Portal.](https://network.developer.nokia.com/sr/learn/yang/understanding-yang/)
- [Learn YANG - Full Tutorial for Beginners - Ultra Config](https://ultraconfig.com.au/blog/learn-yang-full-tutorial-for-beginners/)
- [pyang](https://github.com/mbj4668/)
- [Ultraconfig Generator](https://ultraconfig.com.au/)


