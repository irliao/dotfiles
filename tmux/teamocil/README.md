# Teamocil

Layout file must be ```.yml``` and be in ```~/.teamocil``` to be visible.

To get layout of current window: 

```
tmux list-windows -F "#{window_active} #{window_layout}" | grep "^1" | cut -d " " -f 2
```

