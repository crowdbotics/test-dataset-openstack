#!/bin/bash

echo "Analyzing Python dependencies across repos..."
echo ""

for dir in */; do
    if [ -f "$dir/requirements.txt" ]; then
        echo "=== $dir ==="
        grep -E "(oslo\.|python-.*client|stevedore|taskflow|cliff|pbr)" "$dir/requirements.txt" | head -10
        echo ""
    fi
done

echo ""
echo "Finding repos that import from each other..."
echo ""

for dir in */; do
    if [ -d "$dir" ]; then
        echo "=== $dir ==="
        find "$dir" -name "*.py" -type f -exec grep -l "^import nova\|^from nova\|^import glance\|^from glance\|^import neutron\|^from neutron" {} \; 2>/dev/null | head -5
        echo ""
    fi
done
