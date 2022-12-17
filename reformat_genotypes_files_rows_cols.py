# reformat_genotypes_files_rows_cols.py
# Reformat genotypes files with for each loci the alleles values stored in double rows or in double columns
# input: input file path (either formatted in double rows or double columns) 
#      : format_type: either 'cols_to_rows' (to switch from double columns to double rows)or 'rows_to_cols' (to do the converse)
#      Both cases, compulsory columns names are 'Pop', 'Sample', 'Year', and then loci names
#      In case of alleles stored in double columns, columns names for each allele XX should be written XX_1 and XX_2
# output: reformatted file, either from double rows to double columns or conversely
# --------------------------------------------------------------------------

import pandas as pd
import sys

meta_cols = ['Pop', 'Sample', 'Year']
    
def rows_to_columns(inputfile: str, outputfile: str) -> None:

    input_file = pd.read_csv(inputfile, ";")
    loci_cols = list(set(input_file.columns) - set(meta_cols))
    dfs = list()
    for col in loci_cols:
        df = input_file[meta_cols + [col]]
        df = df.groupby("Sample", as_index=False).apply(lambda x: x.sort_values(col)).reset_index(drop=True)
        dfs.append(df)
 
    data = dfs[0]
    for df, col in zip(dfs[1:], loci_cols[1:]):
        data[col] = df[col]
  
    data_even = data.iloc[::2, :]
    data_even = data_even.rename(columns={col: col + "_1" for col in loci_cols}).reset_index(drop=True)
    data_odd = data.iloc[1::2, :]
    data_odd = data_odd.rename(columns={col: col + "_2" for col in loci_cols}).reset_index(drop=True)
    data = data_even[meta_cols]

    for col in loci_cols:
        data[col + "_1"] = data_even[col + "_1"]
        data[col + "_2"] = data_odd[col + "_2"]
   
    data.to_csv(outputfile, sep=";", index=False)
    return
    
 
def columns_to_rows(inputfile: str, outputfile: str) -> None:
    df = pd.read_csv(inputfile, ";")
    df_1 = df[meta_cols + [col for col in df.columns if "_1" in col]]
    df_1 = df_1.rename(columns={col: col.replace("_1", "") for col in df_1.columns})
    
    df_2 = df[meta_cols + [col for col in df.columns if "_2" in col]]
    df_2 = df_2.rename(columns={col: col.replace("_2", "") for col in df_2.columns})

    df = pd.concat((df_1, df_2), axis=0)
    df = df.sort_values(by="Sample")
    df.to_csv(outputfile, sep=";", index=False)
    return

if __name__ == "__main__":
    
    print("Reformat genotypes files with for each loci the alleles values stored in double rows or in double columns")
    print("Usage: reformat_genotypes_files_rows_cols.py input_file.csv format_type")
    print("with format_type (str) either 'cols_to_rows' (to switch from double columns to double rows)or 'rows_to_cols' (to do the converse)")
    print("with for the input file (csv file with ; as separator) compulsory columns names such as 'Pop', 'Sample', 'Year' and then loci names")
    print("in case of alleles stored in double columns, columns names for each allele XX should be written XX_1 and XX_2")
    
    assert len(sys.argv) == 3, "Wrong number of arguments, expected two: path_input_file and format_type (either 'cols_to_rows' or 'rows_to_cols')" 
    input_file = sys.argv[1]
    format_type  = sys.argv[2]    
    
    if format_type == "cols_to_rows":
        output_file = input_file[:-4] + "_to_rows.csv"
        columns_to_rows(input_file, output_file)
    elif format_type =="rows_to_cols":
        output_file = input_file[:-4] + "_to_cols.csv"
        rows_to_columns(input_file, output_file)
    else:
        raise ValueError("Wrong format_type: should be 'cols_to_rows' or 'rows_to_cols'")