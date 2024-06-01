#!/usr/bin/env python3

# Import
import xml.etree.ElementTree as ET
import sys

def remove_ns(tag):
    """Remove the namespace from the tag."""
    if '}' not in tag:
        return tag
    return tag.split('}', 1)[1]

def linearize(el, path):
    """Linearize the XML element and print its structure."""
    # Print text value if not empty
    text = el.text.strip() if el.text else ""
    if not text:
        print(path)
    else:
        # Several lines?
        lines = text.splitlines()
        if len(lines) > 1:
            for line_nb, line in enumerate(lines, start=1):
                print(f"{path}[line {line_nb}]={line}")
        else:
            print(f"{path}={text}")

    # Print attributes
    for name, val in el.items():
        print(f"{path}/@{remove_ns(name)}={val}")

    # Counter for sibling element names
    counters = {}

    # Loop on child elements
    for child_el in el:
        # Remove namespace
        tag = remove_ns(child_el.tag)

        # Tag name already encountered?
        if tag in counters:
            counters[tag] += 1
        else:
            counters[tag] = 1

        numbered_tag = f"{tag}[{counters[tag]}]"

        # Print child node recursively
        linearize(child_el, f"{path}/{numbered_tag}")

def process(stream, prefix):
    """Process the XML input stream and linearize it."""
    # Parse the XML
    tree = ET.parse(stream)

    # Get root element
    root = tree.getroot()

    # Linearize
    linearize(root, f"{prefix}/{remove_ns(root.tag)}")

def main():
    """Main function to handle input files and standard input."""
    # Each argument is a file
    args = sys.argv[1:]

    # Loop on files
    for filename in args:
        # Open the file
        with open(filename, 'r') as file:
            # If we process several files, prefix each one with its path
            prefix = f"{filename}:" if len(args) > 1 else ""
            # Process it
            process(file, prefix)

    # No input file? => Process std input
    if not args:
        process(sys.stdin, "")

if __name__ == "__main__":
    main()
