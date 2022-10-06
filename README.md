# led_controller

Control the led strips through [the internal-gateway](https://github.com/Sonlis/internal-gateway)

Simple application that sends a json payload to an hard-coded IP address, which has to match the 
internal-gateway's server.

## Payload 

The payload is as such:

```json
{
  "effect": "effect",
  "red": 100,
  "green": 100,
  "blue": 100,
  "speed": 20
}
```

Effect must match the name of configured effects in [here](https://github.com/Sonlis/internal-gateway/blob/main/python/effects.py)
red, green and blue are string representing the RGB starting point of the pattern. Speed is the delay
in millisecond between each iteration of the pattern.