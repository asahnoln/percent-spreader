# Percent spreader

This is a personal project to help me effectively calculate integral percent
division for money distribution among participants.

Sometimes I need to do it evenly as much as possible, most of the time I have
groups of participants, and those groups should have more or less money
distribution than other groups.

For example, I have actors, who should be paid more than other roles, then I
have producers, who should have more than a crew, etc. Finally I might have a
small percent for organization funding.

## Balanced spread

`spreadBalanced` takes count, which then divides 100% as evenly as possible.
For example:

```haskell
> spreadBalanced 5
[20,20,20,20,20]

> spreadBalanced 6
[17,17,17,17,16,16]

> spreadBalanced 9
[12,11,11,11,11,11,11,11,11]
```

## Spread by groups

`spreadByGroups` takes list of Group. Group has Count and Difference. When
percents are calculated, they are separated in their own lists by Count where
an addition of Difference is applied. The last Group plays a fix role, so that
all percents summed up to 100% properly. Last Group Difference is actually
ignored.

```haskell
> spreadByGroups [Group 5 0, Group 5 0]
[[10,10,10,10,10],[10,10,10,10,10]]

> spreadByGroups [Group 5 0, Group 3 0]
[[12,12,12,12,12],[13,13,14]]

> spreadByGroups [Group 5 1, Group 5 0]
[[11,11,11,11,11],[9,9,9,9,9]]

> spreadByGroups [Group 5 1, Group 3 0]
[[13,13,13,13,13],[12,12,11]]

> spreadByGroups [Group 5 1, Group 4 0, Group 3 0]
[[9,9,9,9,9],[8,8,8,8],[8,8,7]]

> spreadByGroups [Group 5 2, Group 4 1, Group 3 0]
[[10,10,10,10,10],[9,9,9,9],[5,5,4]]
```

