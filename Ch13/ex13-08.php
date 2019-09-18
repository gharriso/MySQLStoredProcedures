   $metadata = $stmt->result_metadata();
   $field_cnt = $metadata->field_count;
   while ($colinfo = $metadata->fetch_field()) {
      printf("Column:   %s\n",   $colinfo->name);
      printf("max. Len: %d\n",   $colinfo->max_length);
      printf("Type:     %d\n\n", $colinfo->type);
   }
