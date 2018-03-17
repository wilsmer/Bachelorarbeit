function pd = perc_diff(real_val, app_val)

%pd = abs(abs(app_val) * 100 / abs(real_val) - 100);

pd = abs(100 / abs(real_val) * abs(app_val) - 100);