%module mymodule

// Everything in the %{ ... %} block is simply copied 
// verbatim to the resulting wrapper file created by SWIG
%{
    /// Needed for numpy support
    #define SWIG_FILE_WITH_INIT
%}

/// numpy typemap support
%include "numpy.i"

/// When code is included in the %init section, it is copied directly into the module initialization function.
%init %{
    import_array(); ///< needed for numpy support
%}

/// INPLACE_ARRAY2 essentially means that we are passing a matrix by reference
%apply (double* INPLACE_ARRAY2, int DIM1, int DIM2) {(double* matrix, int rows, int cols)}
%inline %{
    void modify_numpy_matrix(double* matrix, int rows, int cols){
        double val = 0;
        for(int j=0; j<cols; j++)
            for(int i=0; i<rows; i++)
                matrix[i*cols+j] = (++val);
    }
%}

/// With ARGOUTVIEWM_ARRAY2 the C++ new memory will be automatically managed 
%apply (double** ARGOUTVIEWM_ARRAY2, int *DIM1, int *DIM2) {(double** matrix, int* rows, int* cols)}
%inline %{
    void allocate_numpy_matrix(double** matrix, int *rows, int* cols){
        // Don't pass it from Py to demonstrate it can be done in C++
        *rows = 3;
        *cols = 10;
        int nels = (*rows)*(*cols);
        *matrix = new double[nels];
        assert((*matrix)!=NULL);
        
        // Initialization
        for(int i=0; i<nels; i++)
            (*matrix)[i] = 3.14;
    }
%}

