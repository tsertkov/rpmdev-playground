Name:       my-world
Version:    ${VERSION}
Release:    ${RELEASE}
Summary:    Most simple RPM package
License:    FIXME

%description
This is my first RPM package, which does nothing.

%pre
echo "Hello from %%pre scriptlet: $0"

%post
echo "Hello from %%post scriptlet: $0"

%prep
echo "Hello from %%prep"

%build
echo "Hello from %%build"
cat > my-world.sh <<EOF
#!/usr/bin/bash
echo Hello world
EOF

%install
echo "Hello from %%install"
mkdir -p %{buildroot}/usr/bin/
install -m 755 my-world.sh %{buildroot}/usr/bin/my-world.sh

%files
/usr/bin/my-world.sh

%changelog
# let's skip this for now
