# YANG Tools


## Introduction

YANG (Yet Another Next Generation) is a data modeling language used in network management and device configuration. It is primarily associated with the NETCONF (Network Configuration Protocol) and RESTCONF (RESTful Network Configuration) protocols, which are used for network device configuration and management.

YANG formally describes data models for network elements. It provides a way to define the data structure, hierarchy, and constraints for configuration and operational state data. YANG models are written in a human-readable format, making it easier for network engineers to understand and work with. YANG is designed to be platform-independent, allowing it to be used with various networking technologies and protocols.

YANG models are used in conjunction with protocols like NETCONF and RESTCONF to configure and manage network devices. They provide a standardized way to represent device configuration and operational state, improving interoperability and automation.

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

Example YANG Module:

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

This simple YANG module defines a container named *example-container* containing a leaf node named *example-leaf*.

The are several YANG Tools and Utilities that help with using YANG:

- YANG compilers and validators help validate YANG modules for correctness and adherence to the YANG syntax.
- YANG development tools such as Pyang, YANG Explorer, and YANG Development Kit (YDK) assist in creating, editing, and working with YANG models.


## Usage


**Install Required Tools**:

Make sure you have the necessary tools installed. Two commonly used tools are:

- yanglint: A feature-rich tool for validation and conversion of YANG schemas and modeled data. You can use it to validate YANG modules, generate tree representations, and validate JSON/XML instance data¹.
- pyang: A YANG validator, transformator, and code generator written in Python. It can validate YANG modules, transform them into other formats, and generate code from the modules¹.

**Validate YANG Modules**:

Use `yanglint` to validate your YANG module. For example:

```
$ yanglint -p <yang-search-path> module.yang
```
    
This ensures that your YANG module is correct and adheres to the YANG specification.

**Generate Tree Representation**:

To create a tree representation of your YANG module, use:

```
$ yanglint -p <yang-search-path> -f tree module.yang
```

**Convert Instance Data:

Validate JSON or XML instance data using `yanglint`:

```
$ yanglint -p <yang-search-path> module.yang data.json
$ yanglint -p <yang-search-path> -f xml module.yang data.xml
```

You can also convert instance data from one format to another.

**Skeleton Instance Data**:

Generate skeleton instance data (XML or JSON) for your YANG module:

```
XML: $ pyang -p <yang-search-path> -f sample-xml-skeleton --sample-xml-skeleton-defaults module.yang -o module.xml
JSON: $ pyang -p <yang-search-path> -f jsonxsl module.yang -o module.xsl
   $ xsltproc -o module.json module.xsl module.xml
```


**Validate a YANG module**:

```
$ pyang --ietf -p <yang-search-path> module.yang
```

**Generate tree representation of a YANG module**:

```
$ pyang -f tree -p <yang-search-path> module.yang
```

**Indent a YANG file**:

```
$ pyang -p <yang-search-path> \
    --keep-comments -f yang --yang-canonical \
    module.yang -o module.yang
```

**Generate an XML template**:

```
$ pyang -p . -f sample-xml-skeleton --sample-xml-skeleton-defaults pc-components.yang -o pc.xmlls /o	
```

Generate a JSON template
pyang -p <yang-search-path> -f jsonxsl pc-components.yang -o pc.xsl
xsltproc -o pc.json pc.xsl pc.xml


**Validate a module**:

```
$ yanglint pc-components.yang pc.xml
```

## Resources

- [Understanding YANG - Nokia Network Developer Portal.](https://network.developer.nokia.com/sr/learn/yang/understanding-yang/)
- [Learn YANG - Full Tutorial for Beginners - Ultra Config](https://ultraconfig.com.au/blog/learn-yang-full-tutorial-for-beginners/)
- [pyang](https://github.com/mbj4668/)
- [Ultraconfig Generator](https://ultraconfig.com.au/)


