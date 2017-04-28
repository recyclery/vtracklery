# Database Schema

## Statuses

Eg. Volunteer, Member, Paid Staff

| Field  | Description |
| ------ | ----------- |
| `name` | Status name |

## Work Statuses

Eg. Volunteer, Earn-a-bike, Paid

| Field  | Description |
| ------ | ----------- |
| `name` | Status name |

## Workers

| Field            | Description                      |
| ---------------- | -------------------------------- |
| `name`           | Worker's name                    |
| `image`          | Image filename                   |
| `in_shop`        | Current at-work status           |
| `email`          | Email addresss (optional)        |
| `phone`          | 10-digit Phone number (optional) |
| `status_id`      | The worker's current status      |
| `work_status_id` | The worker's current work status |
| `public_email`   | Whether the email should be public (false) |

## Work Times

| Field            | Description                   |
| ---------------- | ----------------------------- |
| `start_at`       | Start time                    |
| `end_at`         | End time                      |
| `worker_id`      | The worker                    |
| `status_id`      | The status for this work      |
| `work_status_id` | The work status for this work |

## Events

| Field      | Description                             |
| ---------- | --------------------------------------- |
| `name`     | The event name, eg. "Tuesday Open Shop" |
| `first_at` | The first date this event begins        |
| `last_at`  | The last date this event runs           |
| `wday`     | The day of the week, eg. '2' (Tuesday)  |
| `s_hr`     | Start hour, eg. '19' or 7pm             |
| `s_min`    | Start minute, eg. '0'                   |
| `e_hr`     | End hour, eg. '21' or 9pm               |
| `e_min`    | End minute, eg. '0'                     |

## Surveys

Surveys were bolted on as a late request, and should probably be spun off into an independant but interlocking application.
They're kept as a single table for simplicity, but the schema should become more complex to support adding more questions in the future.

| Field                    | Description                        |
| ------------------------ | ---------------------------------- |
| `worker_id`              | The worker attached to this survey |
| `assist_host`            | I want to assist program hosts     |
| `host_program`           | I feel ready to host a program     |
| `greet_open`             | For Open Shop I'd like to greet patrons and help with checkout, but not with mechanics |
| `frequency`              | I plan to come in...    |
| `tues_vol`               | Tuesday Volunteer Hours |
| `tues_open`              | Tuesday Open Shop       |
| `thurs_youth`            | Youth Open Shop         |
| `thurs_open`             | Thursday Open Shop      |
| `fri_vol`                | Friday Volunteer Hours  |
| `sat_sale`               | Saturday Sale           |
| `sat_open`               | Saturday Open Shop      |
| `can_name_bike`          | I can... name all parts of a bike        |
| `can_fix_flat`           | fix a flat tire, front and rear          |
| `can_replace_tire`       | find appropriate tube & tire replacement |
| `can_replace_seat`       | replace seat post                        |
| `can_replace_cables`     | replace cables (brake and derailleur)    |
| `can_adjust_brakes`      | adjust brakes                            |
| `can_adjust_derailleurs` | adjust derailleurs                       |
| `can_replace_brakes`     | replace brakes and levers                |
| `can_replace_shifters`   | replace shifters and derailleurs         |
| `can_remove_pedals`      | remove pedals                            |
| `replace_crank`          | replace a crank set                      |
| `can_adjust_bearing`     | get a proper bearing adjustment          |
| `can_overhaul_hubs`      | overhaul hubs                            |
| `can_overhaul_bracket`   | overhaul bottom bracket                  |
| `can_overhaul_headset`   | overhaul headset                         |
| `can_true_wheels`        | true wheels                              |
| `can_replace_fork`       | replace a fork                           |
| `assist_youth`           | I am willing to... Assist with youth programs |
| `assist_tuneup`          | Assist a Tune Up class                        |
| `assist_overhaul`        |   I have taken a Tune Up class before         |
| `pickup_donations`       | Assist an Overhaul class                      |
| `taken_tuneup`           |   I have taken an Overhaul class before       |
| `taken_overhaul`         | Pick up bike donations                        |
| `drive_stick`            |   I can drive stick shift                     |
| `have_vehicle`           |   I have my own vehicle                       |
| `represent_recyclery`    | Represent The Recyclery at events             |
| `sell_ebay`              | Sell higher end bike parts on Ebay            |
| `organize_drive`         | Organize a bike drive                         |
| `organize_events`        | Organize other special events                 |
| `skill_graphic_design`   | I've got these skills: Graphic Design |
| `skill_drawing`          | Drawing/painting                      |
| `skill_photography`      | Photography                           |
| `skill_videography`      | Videography                           |
| `skill_programming`      | Programming                           |
| `skill_grants`           | Writing for grants                    |
| `skill_newsletter`       | Writing for our newsletter            |
| `skill_carpentry`        | Carpentry and design                  |
| `skill_coordination`     | Shop organization/management          |
| `skill_fundraising`      | Fundraising/development               |
| `comment`                | Optional comments                     |
