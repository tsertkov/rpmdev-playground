Name:       ${NAME}
Version:    ${VERSION}
Release:    ${RELEASE}
Summary:    Very simple RPM package
License:    FIXME

%description
This is my first RPM package, which does nothing.

%pre
echo "Executing ${NAME}.sh from %pre scriptlet : $0"
${NAME}.sh || echo "${NAME}.sh is not yet installed"

%post
echo "Executing ${NAME}.sh from %post scriptlet : $0"
${NAME}.sh

%prep
echo "Hello from %%prep"

%build
echo "Hello from %%build"
cat > ${NAME}.sh <<EOF
#!/usr/bin/env bash
echo Hello from ${NAME}-${VERSION}-${RELEASE}! 
EOF

%install
echo "Hello from %%install"
mkdir -p %{buildroot}/usr/bin/
install -m 755 ${NAME}.sh %{buildroot}/usr/bin/${NAME}.sh

%files
/usr/bin/${NAME}.sh

%changelog
# let's skip this for now
