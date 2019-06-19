// RUN: rm -rf %t-mcp
// RUN: mkdir -p %t-mcp

// RUN: %clang_cc1 -x objective-c -isystem %S/Inputs/System/usr/include -dependency-file %t.d.1 -MT %s.o -I %S/Inputs -fsyntax-only -fmodules -fimplicit-module-maps -fmodules-cache-path=%t-mcp %s
// RUN: FileCheck %s < %t.d.1
// CHECK: dependency-gen.m
// CHECK: Inputs{{.}}module.map
// CHECK: Inputs{{.}}diamond_top.h
// CHECK-NOT: usr{{.}}include{{.}}module.map
// CHECK-NOT: stdint.h


// RUN: %clang_cc1 -x objective-c -isystem %S/Inputs/System/usr/include -dependency-file %t.d.2 -MT %s.o -I %S/Inputs -sys-header-deps -fsyntax-only -fmodules -fimplicit-module-maps -fmodules-cache-path=%t-mcp %s
// RUN: FileCheck %s -check-prefix=CHECK-SNAX < %t.d.2
// CHECK-SNAX: dependency-gen.m
// CHECK-SNAX: Inputs{{.}}module.map
// CHECK-SNAX: Inputs{{.}}diamond_top.h
// CHECK-SNAX: usr{{.}}include{{.}}module.map
// CHECK-SNAX: stdint.h

#import "diamond_top.h"
#import "stdint.h" // inside sysroot
