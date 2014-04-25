#!/usr/bin/python

import numpy;
import mymodule;

#--- Create a numpy array
mat = numpy.array([[1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1]],
                   numpy.double)

#--- Attempt to modify it
print "matrix before\n",mat,"\n";
mymodule.modify_numpy_matrix(mat);
print "matrix after\n",mat,"\n";

#--- Create a managed NumPy matrix on the C++ side
mat = mymodule.allocate_numpy_matrix();
print "matrix created in C++\n",mat,"\n";
